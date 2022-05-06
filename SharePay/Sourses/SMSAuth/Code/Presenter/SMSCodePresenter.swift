//
//  SMSCodePresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.05.2022.
//

import Foundation


protocol SMSCodeViewPresenter{
    func resendCode() -> Void
    func checkCode(code: String) -> Void
    func finishAuth() -> Void
}

class SMSCodePresenter: SMSCodeViewPresenter{
        
    weak var view: SMSCodeView?
    var router: RouterProtocol?
    let phoneNumber: String?
    
    required init(view: SMSCodeView, phoneNumber: String,router: RouterProtocol?) {
        self.view = view
        self.router = router
        self.phoneNumber = phoneNumber.filter {!($0.isWhitespace || $0=="+" || $0=="-")}
    }
    
    func resendCode() {
        router?.sharePayService.getSMSCode(phoneNumber: phoneNumber ?? "", completion: { [weak self] (result: Result<Status, Error>) -> Void in
            switch result {
            case .success(let status):
                if status.success{
                    self?.view?.onSuccessResendCode()
                } else {
                    self?.view?.onFailResendCode()
                }
            case .failure(_):
                self?.view?.onFailResendCode()
            }
        })
    }
    
    func checkCode(code: String) {
        router?.sharePayService.login(phoneNumber: phoneNumber ?? "", smsCode: code, completion: { [weak self] (result: Result<Token, Error>) -> Void in
            switch result {
            case .success(let token):
                // Auth process
                self?.router?.sharePayService.setToken(token: token.token)
                self?.router?.authService.setToken(token: token.token)
                self?.view?.onSuccess()
            case .failure(_):
                self?.view?.onIncorrectCode()
            }
        })
    }
    
    func finishAuth(){
        router?.popToRoot()
    }
}
