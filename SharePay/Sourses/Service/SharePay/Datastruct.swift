//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 05.05.2022.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case serverError
}

// Codable структуры для взаимодействия с бэкендом приложения

// AUTH


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


// Purchase

// GET
struct PurchaseCodable: Codable{
    var id: Int
    var description: String?
    var name: String
    var currency: String = "rub" // На начальном этапе только одна валюта
    var emoji: String
    var draft: Bool
    var created_at: String?
    var user_purchases: [PurchaseParticipantCodable]?
    var amount: Int?
    
    init(id: Int = 0,name: String, description: String, emoji: String, participants: [PurchaseParticipantCodable],
         draft: Bool = true,created_at: String = ""){
        self.name = name
        self.description = description
        self.emoji = emoji
        self.user_purchases = participants
        self.id = id
        self.draft = draft
        self.created_at = created_at
    }
}

// CREATE and UPDATE
struct CreateUpdatePurchaseCodable: Codable{
    var id: Int
    var description: String
    var name: String
    var currency: String = "rub" // На начальном этапе только одна валюта
    var emoji: String
    var draft: Bool
    var created_at: String
    var user_purchases_attributes: [PurchaseParticipantCodable]
    
    init(id: Int = 0,name: String, description: String, emoji: String, participants: [PurchaseParticipantCodable],
         draft: Bool = true, created_at: String){
        self.name = name
        self.description = description
        self.emoji = emoji
        self.user_purchases_attributes = participants
        self.id = id
        self.draft = draft
        self.created_at = created_at
    }
}

struct PurchaseParticipantCodable: Codable{
    var user_phone: String
    var amount: Int
    
    init(phone: String, amount: Int){
        self.amount = amount
        self.user_phone = phone
    }
}

struct CreateUpdatePurchaseResponse: Codable{
    var id: Int
    var name: String
    var description: String?
    var emoji: String
    var draft: Bool
    var currency: String
    var created_at: String?
}

// DEBT


struct DebtCodable: Codable{
    var id: Int
    var amount: Int
    var creditor_phone: String
    var debtor_phone: String
    var events: [EventCodable]?
}

struct EventCodable: Codable{
    var amount: Int
    var date: String?
    var name: String?
    var emoji: String?
    var type: String
    var event_id: Int
}

// PAYMENT


struct CreatePaymentCodable: Codable{
    var amount: Int
    var currency: String
    var receiver_phone: String
    
    init(currency: String, receiver_phone: String, amount: Int){
        self.amount = amount
        self.receiver_phone = receiver_phone
        self.currency = currency
    }
}

struct CreatePaymentResponseCodable: Codable{
    var id: Int
    var sender_id: Int
    var receiver_id: Int
    var created_at: String
    var updated_at: String
    var amount: Int
    var currency: String
}

struct PaymentCodable: Codable{
    var amount: Int
    var sender_phone: String
    var receiver_phone: String
    var created_at: String
}
