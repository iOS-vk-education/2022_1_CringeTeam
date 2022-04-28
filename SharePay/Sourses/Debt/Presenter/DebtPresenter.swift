//
//  DebtViewPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 24.04.2022.
//

import Foundation

protocol DebtViewPresenter: AnyObject{
    func listEvents() -> [Event]
    func debtorName() -> String
    func loadData()
    func notifyDebtor()
    func pay(amount: Int)
}

class DebtPresenter: DebtViewPresenter{
    
    weak var view: DebtView?
    var events: [Event] = []
    var totalAmount: Int = 0
    var phoneNumber: String
    var name: String
    
    let defaultCurrency = "₽" // На первом этапе только рублевая валюта
    
    required init(view: DebtView, ownerPhoneNumer: String, ownerName: String) {
        self.phoneNumber = ownerPhoneNumer
        self.name = ownerName
        self.view = view
    }
    
    func loadData(){
        setEvents()
        view?.onCalculateTotalAmount(amount: totalAmount, currency: defaultCurrency)
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
        totalAmount = 0
        for event in events{
            totalAmount+=event.amount
        }
    }
    
    func listEvents() -> [Event]{
        return events
    }
    
    func debtorName() -> String{
        return name
    }
    
    func notifyDebtor() {
        // Implement notification to owner by phone number
    }
    
    func pay(amount: Int){
        // Implement payment
    }
}
