//
//  PurchasesEntity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 20.05.2022.
//

import Foundation

struct PurchaseItem {
    var id: Int
    var emoji: String
    var name: String
    var amount: Int
    var created_at: Date
    var isDraft: Bool
    var currency: String
    
    init(id: Int, emoji: String, name: String, amount: Int, created_at: Date, isDraft: Bool, currency: String){
        self.emoji = emoji
        self.name = name
        self.amount = amount
        self.created_at = created_at
        self.isDraft = isDraft
        self.currency = currency
        self.id = id
    }
}
