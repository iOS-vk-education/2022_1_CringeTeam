//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 24.04.2022.
//

import Foundation

struct Event{
    var name: String
    var emoji: String
    var date: String
    var amount:Int
    var currency: String // На первом этапе одна валюта RUB

    init(name: String, emoji: String, date: String, amount:Int){
        self.amount = amount
        self.emoji = emoji
        self.date = date
        self.name = name
        self.currency = "₽" // На первом этапе только рубль
    }
}
