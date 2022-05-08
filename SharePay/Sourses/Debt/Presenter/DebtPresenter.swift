//
//  DebtViewPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 24.04.2022.
//

import Foundation
import UIKit

protocol DebtViewPresenter: AnyObject{
    func listEvents() -> [Event]
    func getDebt() -> Debt
    func loadData()
    func notifyDebtor()
    func pay(amount: Int64)
    func tapPurchaseEvent(purchase_id: Int64)
    func dismiss()
}

class DebtPresenter: DebtViewPresenter{
    
    var router: RouterProtocol
    weak var view: DebtView?
    var events: [Event] = []
    var debt: Debt
    
    let defaultCurrency = "rub" // На первом этапе только рублевая валюта
    let currencySign: [String: String] = ["rub": "₽"]
    
    required init(view: DebtView, router: RouterProtocol, debtID: Int64) {
        self.router = router
        self.debt = Debt(debtID: debtID)
        self.view = view
    }
    
    func loadData(){
        events = []
        router.sharePayDebtService.getDebt(debtID: debt.debtID, completion: { [weak self]
            (result: Result<DebtCodable, Error>) -> Void in
            switch result {
            case .success(let newDebt):
                
                let userPhoneNumber = self?.router.authService.getPhone()
                var phoneNumber = newDebt.debtor_phone
                if newDebt.debtor_phone == userPhoneNumber{
                    phoneNumber = newDebt.creditor_phone
                }
                
                self?.debt.amount = newDebt.amount
                self?.debt.phoneNumber = phoneNumber
                self?.debt.name =  self?.router.contactService.getNameByPhone(phoneNumber: phoneNumber, defaultName: phoneNumber) ?? ""
                self?.debt.currency = self?.currencySign[self?.defaultCurrency ?? ""] ?? ""
    
                for e in newDebt.events{
                    var newEvent = Event(name: e.description ?? "",
                                         emoji: e.emoji ?? "",
                                         date: e.date?.parseRFC3339Date() ?? Date(),
                                         amount: e.amount,
                                         type: e.type)
                    if newEvent.type == PURCHASE_TYPE{
                        newEvent.purchase_id = e.event_id
                    }
                    self?.events.append(newEvent)
                }
                
                self?.events.sort(by: { (a: Event, b: Event) -> Bool in
                    return a.date > b.date
                })
                
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
    
    func tapPurchaseEvent(purchase_id: Int64){
        router.pushPurchaseView(purchase_id: purchase_id)
    }
    
    func dismiss() {
        router.dismissView()
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
    
    func pay(amount: Int64){
        let createPayment: CreatePaymentCodable = CreatePaymentCodable(currency: defaultCurrency, receiver_phone: debt.phoneNumber, amount: amount)
        router.sharePayPaymentService.createPayment(payment: createPayment, completion: { [weak self]
            (result: Result<CreatePaymentResponseCodable, Error>) -> Void in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.view?.onSuccesPay()
                    self?.loadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view?.onFailPay()
                }
            }
        })
    }
}
