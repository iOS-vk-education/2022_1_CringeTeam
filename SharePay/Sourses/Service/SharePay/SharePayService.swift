//
//  SharepayService.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 05.05.2022.
//

import Foundation
import UIKit

enum ServiceError: Error {
    case invalidURL
    case serverError
}

protocol SharePayServiceProtocol: AnyObject{
    func getSMSCode(phoneNumber: String, completion: @escaping (Result<Data,Error>) -> Void)
    func login(phoneNumber: String, smsCode: String,completion: @escaping (Result<Token,Error>) -> Void)
}


class SharePayService: SharePayServiceProtocol{

    let networkAdapter: NetworkAdapterProtocol = NetworkAdapter()
    let api = "https://sharepay.duckdns.org"
    
    // Получение СМС кода после ввода номера телефона
    func getSMSCode(phoneNumber: String, completion: @escaping (Result<Data,Error>) -> Void) {
        let endpoint = "/auth/login"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let json: [String: Any] = ["auth":["phone": phoneNumber]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData){ (result: Result<Data, Error>) in
            completion(result)
        }
    }
    
    // Авторизация по СМС коду
    func login(phoneNumber: String, smsCode: String, completion: @escaping (Result<Token, Error>) -> Void) {
        let endpoint = "/auth/login"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let json: [String: Any] = ["auth":["phone": phoneNumber, "sms_code": smsCode]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData){ (result: Result<Token, Error>) in
            completion(result)
        }
    }
    
    
    
}
