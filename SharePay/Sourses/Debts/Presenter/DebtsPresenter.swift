//
//  DebtsPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.05.2022.
//

import Foundation

enum debtFilter {
    case all
    case pay
    case remind
}

protocol DebtsViewPresenter: AnyObject{
    func refresh()
    func listDebts() -> [DebtItem]
    func getTotalCount() -> Int
    func getCurrency() -> String
    func openDebt(debt_id: Int)
    func setFilter(filter: debtFilter)
}

class DebtsPresenter: DebtsViewPresenter{
    
    weak var view: DebtsView?
    var router: RouterProtocol
    var debts: [DebtItem]
    var totalAmount: Int
    var filter: debtFilter = .all
    
    init(router: RouterProtocol){
        self.router = router
        self.debts = []
        self.totalAmount = 0
    }
    
    func refresh() {
        router.sharePayDebtService.listDebts(completion: {
            (result: Result<[DebtCodable], Error>) -> Void in
            switch result {
            case .success(let debts):
                self.debts = []
                self.totalAmount = 0
                for debt in debts{
                    self.totalAmount+=debt.amount
                    let userPhoneNumber = self.router.authService.getPhone()
                    var phoneNumber = debt.debtor_phone
                    if debt.debtor_phone == userPhoneNumber {
                        phoneNumber = debt.creditor_phone
                    }
                    
                    let name = self.router.contactService.getNameByPhone(phoneNumber: phoneNumber, defaultName: phoneNumber)
                    
                    self.debts.append(DebtItem(id: debt.id,
                                          name: name, amount: debt.amount))
                }
                DispatchQueue.main.async{
                    self.view?.onSuccesLoad()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onFailedLoad()
                }
            }
        })
    }
    
    func listDebts() -> [DebtItem]{
        switch(filter){
        case .all:
            return debts
        case .pay:
            return debts.filter{$0.amount>0}
        case .remind:
            return debts.filter{$0.amount<0}
        }
    }
    
    func setFilter(filter: debtFilter) {
        self.filter = filter
    }
    
    func openDebt(debt_id: Int){
        router.pushDebtView(debtId: debt_id)
    }
    
    func getTotalCount() -> Int{
        return totalAmount
    }
    
    func getCurrency() -> String{
        return "rub"
    }
    
}
