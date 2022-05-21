//
//  SettingPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.05.2022.
//

import Foundation

protocol SettingViewPresenter: AnyObject{
    func selectLanguage(lang: String)
}

class SettingPresenter: SettingViewPresenter{
    
    var router: RouterProtocol
    weak var view: SettingView?
    var language: String
    
    init(router:RouterProtocol){
        self.router =  router
        self.language = Bundle.getLanguage()
    }
    
    func selectLanguage(lang: String) {
        self.language = lang
        Bundle.setLanguage(lang: language)
    }

}
