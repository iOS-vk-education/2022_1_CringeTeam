//
//  PurchasesPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 20.05.2022.
//

import Foundation

enum purchaseFilter {
    case all
    case draft
    case billed
}

protocol PurchasesViewPresenter: AnyObject{
    func refresh()
    func listPurchases() -> [PurchaseItem]
    func getTotalAmount() -> Int
    func getCurrency() -> String
    func showPurchase(purchase_id: Int)
    func setFilter(filter: purchaseFilter)
}

class PurchasesPresenter: PurchasesViewPresenter{
    
    weak var view: PurchasesView?
    var router: RouterProtocol
    var purchases: [PurchaseItem]
    var totalAmount: Int
    var currency: String = "rub" // На первом этапе только рублевая валюта
    var filter: purchaseFilter = .all
    
    required init(router: RouterProtocol){
        self.router = router
        self.purchases = []
        self.totalAmount = 0
    }
    
    func refresh(){
        router.sharePayPurchaseService.listPurchases(completion: { (result: Result<[PurchaseCodable], Error>) -> Void in
            switch result {
            case .success(let items):
                self.purchases = []
                self.totalAmount = 0
                for item in items{
                    let amount = item.amount ?? 0
                    self.totalAmount+=amount
                    self.purchases.append(PurchaseItem(id: item.id,emoji: item.emoji,
                                                  name: item.name,
                                                       amount: amount,
                                                       created_at: (item.created_at ?? "").parseRFC3339Date(),
                                                       isDraft: item.draft, currency: item.currency))
                }
                DispatchQueue.main.async {
                    self.view?.onSuccessLoad()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onFailesLoad()
                }
            }
        })
    }
    
    func listPurchases() -> [PurchaseItem]{
        switch filter{
        case .all:
            return self.purchases
        case .draft:
            return self.purchases.filter{$0.isDraft}
        case .billed:
            return self.purchases.filter{!$0.isDraft}
        }
    }
    
    func showPurchase(purchase_id: Int) {
        router.presentPurchaseView(purchase_id: purchase_id)
    }
    
    func getTotalAmount() -> Int{
        return totalAmount
    }
    
    func getCurrency() -> String{
        return currency
    }
    
    func setFilter(filter: purchaseFilter){
        self.filter = filter
    }
    
}
