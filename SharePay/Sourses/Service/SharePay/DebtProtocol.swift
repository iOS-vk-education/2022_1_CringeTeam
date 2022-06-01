//
//  DebtProtocol.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 08.05.2022.
//

import Foundation

protocol SharePayDebtProtocol: AnyObject{
    func getDebt(debtID: Int, completion: @escaping (Result<DebtCodable,Error>) -> Void)
    func listDebts(completion: @escaping (Result<[DebtCodable], Error>) -> Void)
    func setToken(token: String)
}

class SharePayDebtService: SharePayDebtProtocol{
    let networkAdapter: NetworkAdapterProtocol = NetworkAdapter()
    let api = "https://sharepay.duckdns.org"
    
    func setToken(token: String) {
        networkAdapter.setToken(authToken: token)
    }
    
    func getDebt(debtID: Int, completion: @escaping (Result<DebtCodable,Error>) -> Void){
        let endpoint = "/debts/\(debtID)"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        self.networkAdapter.request(fromURL: url, httpMethod: .get, httpBody: nil,withToken: true, completion: completion)
    }
    
    func listDebts(completion: @escaping (Result<[DebtCodable], Error>) -> Void){
        let endpoint = "/debts"
        guard let url = URL(string: api+endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        self.networkAdapter.request(fromURL: url, httpMethod: .get, httpBody: nil,withToken: true, completion: completion)
    }
}
