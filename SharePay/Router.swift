//
//  Router.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 05.05.2022.
//

import Foundation
import UIKit

protocol RouterEssential: AnyObject{
    var navigationController: UINavigationController? {get set}
    var assembleBuilder: AssembleProtocol? {get set}
    var sharePayAuthService: SharePayAuthProtocol{get set}
    var sharePayPurchaseService: SharePayPurchaseProtocol{get set}
    var sharePayDebtService: SharePayDebtProtocol{get set}
    var sharePayPaymentService: SharePayPaymentsProtocol{get set}
    var authService: AuthServiceProtocol {get set}
    var userService: UserServiceProtocol {get set}
    var contactService: ContactServiceProtocol {get set}
}

protocol RouterProtocol: RouterEssential{
    func initialViewController()
    func pushSMSView(phoneNumber: String)
    func presentPurchaseView(purchase_id: Int)
    func pushPurchaseView(purchase_id: Int)
    func pushDebtView(debtId: Int)
    func popToRoot()
    func dismissView()
    func setToken(token: String)
}

enum ViewMode {
    case push
    case present
}


class Router: RouterProtocol{
    
    var sharePayPaymentService: SharePayPaymentsProtocol
    var sharePayDebtService: SharePayDebtProtocol
    var sharePayAuthService: SharePayAuthProtocol
    var sharePayPurchaseService: SharePayPurchaseProtocol
    var authService: AuthServiceProtocol
    var userService: UserServiceProtocol
    var navigationController: UINavigationController?
    var assembleBuilder: AssembleProtocol?
    var contactService: ContactServiceProtocol
    
    init(navigationController: UINavigationController?, assembleBuilder: AssembleProtocol?){
        self.navigationController =  navigationController
        self.assembleBuilder = assembleBuilder
        self.authService = AuthService()
        self.userService = UserService()
        self.sharePayAuthService = SharePayAuthService()
        self.sharePayPurchaseService = SharePayPurchaseService()
        self.contactService = ContactService()
        self.sharePayDebtService = SharePayDebtService()
        self.sharePayPaymentService = SharePayPaymentsService()
        
        // TODO для тестирования под несколькими пользователями
        authService.destroyAllData()
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assembleBuilder?.createMainViewController(router: self) else{ return}
            navigationController.viewControllers = [mainViewController]
            
            // TODO onboard check
            if !authService.isAuth(){
                guard let phoneNumberViewController = assembleBuilder?.createPhoneNumberModule(router: self)else{ return}
                navigationController.pushViewController(phoneNumberViewController, animated: true)
                return
            }
            self.setToken(token: authService.getToken())
        }
    }
    
    func pushSMSView(phoneNumber: String) {
        if let navigationController = navigationController {
            guard let smsViewControler = assembleBuilder?.createSMSCodeNumberModule(router: self, phoneNumber: phoneNumber) else { return}
            navigationController.pushViewController(smsViewControler, animated: true)
        }
    }
    
    func presentPurchaseView(purchase_id: Int = 0){
        if let navigationController = navigationController {
            guard let purchaseViewControler = assembleBuilder?.createPurchaseViewController(router: self, purchase_id: purchase_id, mode: .present) else { return}
            navigationController.present(purchaseViewControler, animated: true, completion: nil)
        }
    }
    
    func pushPurchaseView(purchase_id: Int = 0){
        if let navigationController = navigationController {
            guard let purchaseViewControler = assembleBuilder?.createPurchaseViewController(router: self, purchase_id: purchase_id, mode: .push) else { return}
            navigationController.pushViewController(purchaseViewControler, animated: true)
        }
    }
    
    func pushDebtView(debtId: Int = 0){
        if let navigationController = navigationController {
            guard let debtViewControler = assembleBuilder?.createDebtViewController(router: self, debtID: debtId) else { return}
            navigationController.pushViewController(debtViewControler, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func dismissView(){
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
    
    func setToken(token: String){
        // Если пользователь авторизован необходимо указать актуальный токен длля сервисов бэкенда
        sharePayPurchaseService.setToken(token: token)
        sharePayDebtService.setToken(token: token)
        sharePayPaymentService.setToken(token: token)
    }
}
