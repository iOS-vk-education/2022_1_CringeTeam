//
//  SharepayService.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 05.05.2022.
//

import Foundation
import UIKit

enum ServiceError: Error {
    case invalidURL
    case serverError
}

protocol SharePayServiceProtocol: SharePayAuthProtocol{}

class SharePayService: SharePayServiceProtocol{
    let networkAdapter: NetworkAdapterProtocol = NetworkAdapter()
    let api = "https://sharepay.duckdns.org"
}
