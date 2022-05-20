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
    func createPurchaseViewController(router: RouterProtocol, purchase_id: Int, mode: ViewMode) -> UIViewController
    func createDebtViewController(router: RouterProtocol, debtID: Int) -> UIViewController
    func createTrasnfersViewController(router: RouterProtocol) -> UIViewController
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
        let presenter = TabPresenter(router: router)
        let view = TabViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createPurchaseViewController(router: RouterProtocol, purchase_id: Int = 0, mode: ViewMode) -> UIViewController{
        let view = PurchaseViewController()
        let presenter = PurchasePresenter(view: view, router: router, purchase_id: purchase_id, mode: mode)
        view.presenter = presenter
        return view
    }
    
    func createDebtViewController(router: RouterProtocol, debtID: Int) -> UIViewController{
        let view = DebtViewController()
        let presenter = DebtPresenter(view: view, router: router, debtID: debtID)
        view.presenter = presenter
        return view
    }
    
    func createTrasnfersViewController(router: RouterProtocol) -> UIViewController {
        let view = TransfersViewController()
        let presenter = TransfersPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
}


