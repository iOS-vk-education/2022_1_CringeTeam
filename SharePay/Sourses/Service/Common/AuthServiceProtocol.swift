//
//  AuthService.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.05.2022.
//

import Foundation
import KeychainSwift

protocol AuthServiceProtocol: AnyObject {
    func getToken() -> String
    func setToken(token: String) -> Void
    func getPhone() -> String
    func setPhone(phone: String) -> Void
    func isAuth() -> Bool
}


class AuthService: AuthServiceProtocol {
    let TOKEN_KEY: String = "SHARE_PAY_TOKEN"
    let PHONE_KEY: String = "SHARE_PAY_PHONE"
    let EMPTY: String = ""
    
    func getToken() -> String{
        let keychain = KeychainSwift()
        guard let data = keychain.getData(TOKEN_KEY) else {return EMPTY}
        return String(decoding: data, as: UTF8.self)
    }
    
    func setToken(token: String) -> Void{
        let keychain = KeychainSwift()
        keychain.set(token, forKey: TOKEN_KEY)
    }
    
    func setPhone(phone: String) -> Void{
        let keychain = KeychainSwift()
        keychain.set(phone, forKey: PHONE_KEY)
    }
    
    func getPhone() -> String{
        let keychain = KeychainSwift()
        guard let data = keychain.getData(PHONE_KEY) else {return EMPTY}
        return String(decoding: data, as: UTF8.self)
    }
    
    func isAuth() -> Bool{
        let keychain = KeychainSwift()
        if keychain.getData(TOKEN_KEY) != nil{
            return true
        }
        return false
    }
   
}
