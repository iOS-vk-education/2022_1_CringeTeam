//
//  SettingPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.05.2022.
//

import Foundation

protocol SettingViewPresenter: AnyObject{
    func selectLanguage(lang: String)
    func listLanguageItems() -> [LanguageItem]
    func getSelectedLanguageCode() -> String
}

class SettingPresenter: SettingViewPresenter{
    
    var router: RouterProtocol
    weak var view: SettingView?
    var selectedLanguage: String
    var languageItems: [LanguageItem]
    
    init(router:RouterProtocol){
        self.router =  router
        self.selectedLanguage = Bundle.getLanguage()
        languageItems = []
        self.initLanguageItems()
    }
    
    func initLanguageItems(){
        self.languageItems =
        [LanguageItem(name: "Lang.Russian".localized(), code: "ru"),
         LanguageItem(name: "Lang.English".localized(), code: "en")]
    }
    
    func listLanguageItems() -> [LanguageItem] {
        return languageItems
    }
    
    func selectLanguage(lang: String) {
        self.selectedLanguage = lang
        Bundle.setLanguage(lang: selectedLanguage)
        initLanguageItems()
    }
    
    func getSelectedLanguageCode() -> String{
        return self.selectedLanguage
    }

}
