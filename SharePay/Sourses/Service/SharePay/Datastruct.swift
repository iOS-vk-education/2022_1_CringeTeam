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
