//
//  PurchasesProtocol.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 06.05.2022.
//

import Foundation


protocol SharePayPurchaseProtocol: AnyObject{
    func createPurchase(purchase: CreateUpdatePurchaseCodable, completion: @escaping (Result<CreateUpdatePurchaseResponse,Error>) -> Void)
    func updatePurchase(purchase: CreateUpdatePurchaseCodable, purchase_id: Int,
                        completion: @escaping (Result<CreateUpdatePurchaseResponse,Error>) -> Void)
    func getPurchase(purchase_id: Int, completion: @escaping (Result<PurchaseCodable,Error>) -> Void)
    func deletePurchase(purchase_id: Int, completion: @escaping (Result<Status,Error>) -> Void)
    func setToken(token: String)
}

class SharePayPurchaseService: SharePayPurchaseProtocol{
    
    let networkAdapter: NetworkAdapterProtocol = NetworkAdapter()
    let api = "https://sharepay.duckdns.org"
    
    func setToken(token: String) {
        networkAdapter.setToken(authToken: token)
    }
    
    func createPurchase(purchase:  CreateUpdatePurchaseCodable, completion: @escaping (Result<CreateUpdatePurchaseResponse,Error>) -> Void){
        let endpoint = "/purchases"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let encoder: JSONEncoder = JSONEncoder()
        let jsonData = try? encoder.encode(purchase)
        self.networkAdapter.request(fromURL: url, httpMethod: .post, httpBody: jsonData,withToken: true, completion: completion)
    }
    
    func updatePurchase(purchase: CreateUpdatePurchaseCodable, purchase_id: Int,
                        completion: @escaping (Result<CreateUpdatePurchaseResponse,Error>) -> Void){
        let endpoint = "/purchases/\(purchase_id)"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        let encoder: JSONEncoder = JSONEncoder()
        let jsonData = try? encoder.encode(purchase)
        self.networkAdapter.request(fromURL: url, httpMethod: .patch, httpBody: jsonData,withToken: true, completion: completion)
    }
    
    func getPurchase(purchase_id: Int, completion: @escaping (Result<PurchaseCodable,Error>) -> Void){
        let endpoint = "/purchases/\(purchase_id)"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        self.networkAdapter.request(fromURL: url, httpMethod: .get, httpBody: nil,  withToken: true, completion: completion)
        
    }
    
    func deletePurchase(purchase_id: Int, completion: @escaping (Result<Status,Error>) -> Void){
        let endpoint = "/purchases/\(purchase_id)"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        self.networkAdapter.request(fromURL: url, httpMethod: .delete, httpBody: nil,  withToken: true, completion: completion)
    }
}
