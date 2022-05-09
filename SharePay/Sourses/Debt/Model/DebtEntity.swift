//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 24.04.2022.
//

import Foundation

let PAYMENT_TYPE = "payment"
let PURCHASE_TYPE = "purchase"

struct Debt{
    var phoneNumber: String
    var debtID: Int64
    var name: String
    var amount: Int64
    var currency: String
    
    init(debtID: Int64, phoneNumber: String = "", name: String = "",
         amount: Int64 = 0, currecny: String = ""){
        self.debtID = debtID
        self.phoneNumber = phoneNumber
        self.name = name
        self.amount = amount
        self.currency = currecny
    }
}

struct Event{
    
    var name: String
    var emoji: String
    var date: Date
    var amount: Int64
    var currency: String // На первом этапе одна валюта RUB
    var type: String
    var purchase_id: Int64

    init(name: String, emoji: String, date: Date,
         amount:Int64, type: String, purchase_id: Int64 = 0){
        self.amount = amount
        self.emoji = emoji
        self.date = date
        self.name = name
        self.currency = "₽" // На первом этапе только рубль
        self.type = type
        self.purchase_id = purchase_id
    }
}
