//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 05.05.2022.
//

import Foundation

struct Token: Codable{
    var token: String
    
    init(token: String){
        self.token = token
    }
}

struct Status: Codable{
    var success: Bool
    
    init(success: Bool){
        self.success = success
    }
}

struct PurchaseService: Codable{
    var id: Int64
    var description: String
    var name: String
    var currency: String = "rub" // На начальном этапе только одна валюта
    var emoji: String
    var user_purchases: [PurchaseParticipantService]
    
    init(id: Int64 = 0,name: String, description: String, emoji: String, participants: [PurchaseParticipantService]){
        self.name = name
        self.description = description
        self.emoji = emoji
        self.user_purchases = participants
        self.id = id
    }
}

struct PurchaseParticipantService: Codable{
    var user_phone: String
    var amount: Int64
    
    init(phone: String, amount: Int64){
        self.amount = amount
        self.user_phone = phone
    }
}

struct CreatePurchaseResponse: Codable{
    var id: String
    var name: String
    var description: String
    var emoji: String
    var currency: String
}

// Temporary
struct PurchaseWrapService: Codable{
    var purchase: PurchaseService
}
