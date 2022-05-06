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
    func createPurchaseViewController(router: RouterProtocol) -> UIViewController
    func createDebtViewController(router: RouterProtocol, phoneNumber: String, ownerName: String) -> UIViewController
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
    
    func createPurchaseViewController(router: RouterProtocol) -> UIViewController{
        let view = PurchaseViewController()
        let presenter = PurchasePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createDebtViewController(router: RouterProtocol, phoneNumber: String, ownerName: String) -> UIViewController{
        let view = DebtViewController()
        let presenter = DebtPresenter(view: view, ownerPhoneNumer: phoneNumber, ownerName: ownerName)
        view.presenter = presenter
        return view
    }
    
}


