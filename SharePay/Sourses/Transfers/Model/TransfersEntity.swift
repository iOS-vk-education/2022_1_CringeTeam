//
//  TransfersEntity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 15.05.2022.
//

import Foundation

struct Transfer{
    var amount: Int
    var phone: String
    var name: String
    var created_at: Date

    init(amount: Int, phone: String, name: String, created_at: Date){
        self.amount = amount
        self.phone = phone
        self.name = name
        self.created_at = created_at
    }
}
