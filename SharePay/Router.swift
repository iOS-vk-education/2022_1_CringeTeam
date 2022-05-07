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
    var authService: AuthServiceProtocol {get set}
    var userService: UserServiceProtocol {get set}
    var contactService: ContactServiceProtocol {get set}
}

protocol RouterProtocol: RouterEssential{
    func initialViewController()
    func showSMSView(phoneNumber: String)
    func showPurchaseView(purchase_id: Int64)
    func popToRoot()
    func dismissView()
    func setToken(token: String)
}


class Router: RouterProtocol{
    
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
    
    func showSMSView(phoneNumber: String) {
        if let navigationController = navigationController {
            guard let smsViewControler = assembleBuilder?.createSMSCodeNumberModule(router: self, phoneNumber: phoneNumber) else { return}
            navigationController.pushViewController(smsViewControler, animated: true)
        }
    }
    
    func showPurchaseView(purchase_id: Int64 = 0){
        if let navigationController = navigationController {
            guard let purchaseViewControler = assembleBuilder?.createPurchaseViewController(router: self, purchase_id: purchase_id) else { return}
            navigationController.present(purchaseViewControler, animated: true, completion: nil)
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
        // Если пользователь авторизован необходимо указать актуальный токен длля сервиса
        sharePayPurchaseService.setToken(token: authService.getToken())
    }
}
