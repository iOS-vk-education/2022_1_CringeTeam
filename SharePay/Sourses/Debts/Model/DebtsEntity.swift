//
//  DebtsEntity.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.05.2022.
//

import Foundation

struct DebtItem {
    var id: Int
    var name: String
    var amount: Int
    
    init(id: Int, name: String, amount: Int){
        self.id = id
        self.name = name
        self.amount = amount
    }
}
