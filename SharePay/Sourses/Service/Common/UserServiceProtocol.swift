//
//  UserService.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.05.2022.
//

import Foundation

protocol UserServiceProtocol: AnyObject{
    func setOnBoardingStatus(isShown: Bool) -> Void
    func onBoardingIsShown() -> Bool
}

class UserService: UserServiceProtocol{
        
    let userDefaults = UserDefaults.standard
    let ONBOARDING_KEY: String = "ONBOARDING_STATUS"
    
    func setOnBoardingStatus(isShown: Bool) {
        userDefaults.set(isShown, forKey: ONBOARDING_KEY)
    }
    
    func onBoardingIsShown() -> Bool {
        return userDefaults.object(forKey: ONBOARDING_KEY) as? Bool ?? false
    }

}
