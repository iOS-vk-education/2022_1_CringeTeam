//
//  Builder.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.05.2022.
//

import Foundation
import UIKit

protocol AssembleProtocol: AnyObject {
    func createPhoneNumberModule(router: RouterProtocol) -> UIViewController
    func createSMSCodeNumberModule(router: RouterProtocol, phoneNumber: String) -> UIViewController
    func createMainViewController(router: RouterProtocol) -> UIViewController
}

class Assemble: AssembleProtocol{
    
    func createPhoneNumberModule(router: RouterProtocol) -> UIViewController{
        let view = PhoneNumberViewController()
        let presenter = PhoneNumberPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSMSCodeNumberModule(router: RouterProtocol, phoneNumber: String) -> UIViewController{
        let view = SMSCodeViewController()
        let presenter = SMSCodePresenter(view: view, phoneNumber: phoneNumber,router: router)
        view.presenter = presenter
        return view
    }
    
    func createMainViewController(router: RouterProtocol) -> UIViewController{
        let view = TabViewController()
        return view
        // TODO MVP assemble
    }
    
}


