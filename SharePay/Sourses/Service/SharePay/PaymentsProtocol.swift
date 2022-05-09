//
//  PaymentsProtocol.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 06.05.2022.
//

import Foundation

protocol SharePayPaymentsProtocol: AnyObject{
    func createPayment(payment: CreatePaymentCodable,
                       completion: @escaping (Result<CreatePaymentResponseCodable,Error>) -> Void)
    func setToken(token: String)
}

class SharePayPaymentsService: SharePayPaymentsProtocol{
    let networkAdapter: NetworkAdapterProtocol = NetworkAdapter()
    let api = "https://sharepay.duckdns.org"
    
    func setToken(token: String) {
        networkAdapter.setToken(authToken: token)
    }
    
    
    func createPayment(payment: CreatePaymentCodable,
                       completion: @escaping (Result<CreatePaymentResponseCodable,Error>) -> Void){
        let endpoint = "/payments"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let encoder: JSONEncoder = JSONEncoder()
        let jsonData = try? encoder.encode(payment)
        self.networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData,withToken: true, completion: completion)
    }
}
