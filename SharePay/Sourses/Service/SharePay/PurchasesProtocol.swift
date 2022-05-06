//
//  PurchasesProtocol.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 06.05.2022.
//

import Foundation


protocol SharePayPurchasesProtocol: AnyObject{
    func createPurchase(purchase: PurchaseService, completion: @escaping (Result<CreatePurchaseResponse,Error>) -> Void)
    func getPurchase(purchase_id: Int64, completion: @escaping (Result<PurchaseWrapService,Error>) -> Void)
}

extension SharePayService: SharePayPurchasesProtocol{
    func createPurchase(purchase:  PurchaseService, completion: @escaping (Result<CreatePurchaseResponse,Error>) -> Void){
        let endpoint = "/purchases"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let json: [String: Any] = ["purchase":purchase]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        self.networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData,withToken: true, completion: {(result: Result<CreatePurchaseResponse, Error>) -> Void in
            completion(result)
        })
    }
    
    func getPurchase(purchase_id: Int64, completion: @escaping (Result<PurchaseWrapService,Error>) -> Void){
        let endpoint = "/purchases/\(purchase_id)"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        self.networkAdapter.request(fromURL: url, httpMethod: .get, httpBody: nil,  withToken: true, completion: completion)
        
    }
}
