//
//  Entity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 18.04.2022.
//

import Foundation

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
