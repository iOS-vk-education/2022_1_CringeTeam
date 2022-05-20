//
//  TabViewPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 07.05.2022.
//

import Foundation

protocol TabViewPresenter: AnyObject{
    func showNewPurchase()
    func getRouter() -> RouterProtocol
}

class TabPresenter: TabViewPresenter{
    weak var view: TabView?
    var router: RouterProtocol
    
    init(router: RouterProtocol){
        self.router = router
    }
    
    func showNewPurchase() {
        // Покупка новая -> purchase_id = 0
        router.presentPurchaseView(purchase_id: 0)
    }
    
    func getRouter() ->RouterProtocol {
        return router
    }
}
