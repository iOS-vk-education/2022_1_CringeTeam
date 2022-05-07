//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 24.04.2022.
//

import Foundation


struct Debt{
    var phoneNumber: String
    var debtID: Int64
    var name: String
    var amount: Int64
    var currency: String
    
    init(debtID: Int64, phoneNumber: String = "", name: String = "", amount: Int64 = 0, currecny: String = ""){
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
    var date: String
    var amount: Int64
    var currency: String // На первом этапе одна валюта RUB

    init(name: String, emoji: String, date: String, amount:Int64){
        self.amount = amount
        self.emoji = emoji
        self.date = date
        self.name = name
        self.currency = "₽" // На первом этапе только рубль
    }
}
