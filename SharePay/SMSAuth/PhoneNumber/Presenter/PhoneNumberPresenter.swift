//
//  PhoneNumberPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.05.2022.
//

import Foundation

protocol PhoneNumberViewPresenter: AnyObject{
    func tapContinue(phoneNumber: String) -> Void
}

final class PhoneNumberPresenter: PhoneNumberViewPresenter{
    
    weak var view: PhoneNumberView?
    var router: RouterProtocol?
    
    required init(view: PhoneNumberView, router: RouterProtocol?) {
        self.view = view
        self.router = router
    }
    
    func tapContinue(phoneNumber: String) {
        let number = phoneNumber.filter {!($0.isWhitespace || $0=="+" || $0=="-")}
        if isValidPhoneNumber(phoneNumber: number){
            router?.sharePayService.getSMSCode(phoneNumber: phoneNumber, completion: { [weak self] (result: Result<Status,Error>) -> Void in
                switch result {
                case .success(let status):
                    if status.success{
                        self?.view?.onSuccess()
                        self?.router?.showSMSView(phoneNumber: phoneNumber)
                    } else {
                        self?.view?.onServerFail()
                    }
                case .failure(_):
                    self?.view?.onServerFail()
                }
            })
        } else{
            view?.onInvalidNumber()
        }
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool{
        let PHONE_REGEX = "^\\d{11}$" // ex. 79999999999
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: phoneNumber)
        return result
    }
}
