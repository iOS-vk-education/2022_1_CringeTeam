//
//  TabViewPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 07.05.2022.
//

import Foundation

protocol TabViewPresenter: AnyObject{
    func newPurchase()
}


class TabPresenter: TabViewPresenter{
    weak var view: TabView?
    var router: RouterProtocol
    
    init(view: TabView, router: RouterProtocol){
        self.view = view
        self.router = router
    }
    
    func newPurchase() {
        // Покупка новая -> purchase_id = 0
       // router.showPurchaseView(purchase_id: 0)
        router.showDebtView(debtId: 1)
    }
}
