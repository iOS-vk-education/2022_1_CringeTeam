//
//  NetworkManager.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.05.2022.
//

import Foundation

enum ManagerErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

enum HttpMethod: String {
    case get
    case post

    var method: String { rawValue.uppercased() }
}

protocol NetworkAdapterProtocol: AnyObject{
    func request<T: Decodable>(fromURL url: URL, httpMethod: HttpMethod,
                               httpBody: Data?, withToken: Bool,
                               completion: @escaping (Result<T, Error>) -> Void)
    func setToken(authToken: String)
}

class NetworkAdapter: NetworkAdapterProtocol {
    
    var authToken: String = ""
    
    func setToken(authToken: String){
        self.authToken = authToken
    }

    func request<T: Decodable>(fromURL url: URL, httpMethod: HttpMethod = .get,
                               httpBody: Data? = nil, withToken: Bool,
                               completion: @escaping (Result<T, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        request.httpBody = httpBody
        if httpBody != nil{
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }

        if withToken{
            request.setValue("Bearer \(self.authToken)", forHTTPHeaderField: "Authorization")
        }
        

        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completion(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }

            guard let data = data else { return }
            do {
                let tData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(tData))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        urlSession.resume()
    }
}
