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
        router?.sharePayAuthService.getSMSCode(phoneNumber: phoneNumber ?? "", completion: { [weak self] (result: Result<Status, Error>) -> Void in
            switch result {
            case .success(let status):
                DispatchQueue.main.async {
                    if status.success{
                        self?.view?.onSuccessResendCode()
                    } else {
                        self?.view?.onFailResendCode()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async{
                    self?.view?.onFailResendCode()
                }
            }
        })
    }
    
    func checkCode(code: String) {
        router?.sharePayAuthService.login(phoneNumber: phoneNumber ?? "", smsCode: code, completion: { [weak self] (result: Result<Token, Error>) -> Void in
            switch result {
            case .success(let token):
                // Auth process
                self?.router?.setToken(token: token.token)
                self?.router?.authService.setToken(token: token.token)
                self?.router?.authService.setPhone(phone: self?.phoneNumber ?? "")
                DispatchQueue.main.async {
                    self?.view?.onSuccess()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view?.onIncorrectCode()
                }
            }
        })
    }
    
    func finishAuth(){
        router?.setMainViewController()
    }
}
