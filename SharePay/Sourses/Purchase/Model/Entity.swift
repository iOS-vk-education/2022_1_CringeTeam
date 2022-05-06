//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 18.04.2022.
//

import Foundation


struct Purchase{
    var description: String // TODO
    var name: String
    var emoji: String
    var draft: Bool
    var id: Int64
    var amount: Int64
   // var created_at: Date TODO
    
    init(id: Int64, name: String = "", description: String = "", emoji: String = "",
         draft: Bool = true, amount: Int64 = 0){
        self.id = id
        self.name =  name
        self.description = description
        self.emoji = emoji
        self.draft = draft
        self.amount = amount
    }
}

struct PurchaseParticipant {
    var phoneNumber: String
    var name: String
    var amount: Int64
    init(phoneNumber: String, name: String, amount: Int64){
        self.amount = amount
        self.name = name
        self.phoneNumber = phoneNumber
    }
}
