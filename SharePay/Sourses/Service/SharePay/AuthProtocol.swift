//
//  AuthProtocol.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 06.05.2022.
//

import Foundation

protocol SharePayAuthProtocol: AnyObject{
    func getSMSCode(phoneNumber: String, completion: @escaping (Result<Status,Error>) -> Void)
    func login(phoneNumber: String, smsCode: String,completion: @escaping (Result<Token,Error>) -> Void)
}


class SharePayAuthService: SharePayAuthProtocol{
    
    let networkAdapter: NetworkAdapterProtocol = NetworkAdapter()
    let api = "https://sharepay.duckdns.org"
    
    // Получение СМС кода после ввода номера телефона
    func getSMSCode(phoneNumber: String, completion: @escaping (Result<Status,Error>) -> Void) {
        let endpoint = "/auth/login"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let json: [String: Any] = ["phone": phoneNumber]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData, withToken: false){ (result: Result<Status, Error>) in
            completion(result)
        }
    }
    
    // Авторизация по СМC-коду
    func login(phoneNumber: String, smsCode: String, completion: @escaping (Result<Token, Error>) -> Void) {
        let endpoint = "/auth/login"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let json: [String: Any] = ["phone": phoneNumber, "sms_code": smsCode]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData, withToken: false){ (result: Result<Token, Error>) in
            completion(result)
        }
    }
}
