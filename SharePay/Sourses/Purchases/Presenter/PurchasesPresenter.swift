//
//  PurchasesPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 20.05.2022.
//

import Foundation

protocol PurchasesViewPresenter: AnyObject{
    func viewDidLoad()
    func listPurchases() -> [PurchaseItem]
    func getTotalAmount() -> Int
    func getCurrency() -> String
    func showPurchase(purchase_id: Int)
}

class PurchasesPresenter: PurchasesViewPresenter{
    
    weak var view: PurchasesView?
    var router: RouterProtocol
    var purchases: [PurchaseItem]
    var totalAmount: Int
    var currency: String = "rub" // На первом этапе только рублевая валюта
    
    required init(router: RouterProtocol){
        self.router = router
        self.purchases = []
        self.totalAmount = 0
    }
    
    func viewDidLoad(){
        router.sharePayPurchaseService.listPurchases(completion: { (result: Result<[PurchaseCodable], Error>) -> Void in
            switch result {
            case .success(let items):
                self.purchases = []
                self.totalAmount = 0
                for item in items{
                    let amount = Int.random(in: 1..<100) // TODO
                    self.totalAmount+=amount
                    self.purchases.append(PurchaseItem(id: item.id,emoji: item.emoji,
                                                  name: item.name,
                                                       amount: amount,
                                                       created_at: item.created_at.parseRFC3339Date(),
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
        return self.purchases
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
    
}
