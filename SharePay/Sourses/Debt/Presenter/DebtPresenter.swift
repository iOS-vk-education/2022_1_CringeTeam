//
//  DebtViewPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 24.04.2022.
//

import Foundation

protocol DebtViewPresenter: AnyObject{
    func listEvents() -> [Event]
    func getDebt() -> Debt
    func loadData()
    func notifyDebtor()
    func pay(amount: Int)
    func dismiss()
}

class DebtPresenter: DebtViewPresenter{
    
    var router: RouterProtocol
    weak var view: DebtView?
    var events: [Event] = []
    var debt: Debt
    
    let defaultCurrency = "₽" // На первом этапе только рублевая валюта
    
    required init(view: DebtView, router: RouterProtocol, debtID: Int64) {
        self.router = router
        self.debt = Debt(debtID: debtID)
        self.view = view
    }
    
    func loadData(){
        router.sharePayDebtService.getDebt(debtID: debt.debtID, completion: { [weak self]
            (result: Result<DebtCodable, Error>) -> Void in
            switch result {
            case .success(let newDebt):
                self?.debt.amount = newDebt.amount
     
                let userPhoneNumber = self?.router.authService.getPhone()
                var phoneNumber = newDebt.debtor_phone
                if newDebt.creditor_phone == userPhoneNumber{
                    phoneNumber = newDebt.creditor_phone
                }
                
                self?.debt.phoneNumber = phoneNumber
                self?.debt.name =  self?.router.contactService.getNameByPhone(phoneNumber: phoneNumber, defaultName: phoneNumber) ?? ""
                self?.debt.currency = self?.defaultCurrency ?? ""
                
                for e in newDebt.events{
                    self?.events.append(Event(name: e.description ?? "", emoji: e.emoji ?? "", date: e.date ?? "", amount: e.amount))
                }
                
                DispatchQueue.main.async {
                    self?.view?.onLoadDebt()
                    self?.view?.onLoadEvents()
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view?.onFailLoadDebt()
                }
            }
        })
    }
    
    func getNotUserPhoneNumber(){
        
    }
    
    func dismiss() {
        router.dismissView()
    }
     
    // Моковые значения для тестирования
    // TODO заменить при интеграции на реальные данные
    func setEvents(){
        events = [
            Event(name: "Поход в кино", emoji: "🎥", date: "12.05.2021", amount: -2000),
            Event(name: "Поездка на море", emoji: "🌴", date: "12.05.2022", amount: -10000),
            Event(name: "Зачисление", emoji: "💸", date: "12.05.2022", amount: 1000),
            Event(name: "Роллы", emoji: "🇯🇵", date: "12.05.2021", amount: -1000),
            Event(name: "Зачисление", emoji: "💸", date: "12.05.2022", amount: 200),
            Event(name: "Виноград", emoji: "🍇", date: "12.05.2022", amount: -2000),
        ]
        calculateTotal()
    }
    
    func calculateTotal(){
        var totalAmount: Int64 = 0
        for event in events{
            totalAmount+=event.amount
        }
        debt.amount = totalAmount
    }
    
    func listEvents() -> [Event]{
        return events
    }
    
    func getDebt() -> Debt{
        return debt
    }
    
    func notifyDebtor() {
        // Implement notification to owner by phone number
    }
    
    func pay(amount: Int){
        // Implement payment
    }
}
