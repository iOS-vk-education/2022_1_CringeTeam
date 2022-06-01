//
//  PurchasePresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 18.04.2022.
//

import Foundation
import ContactsUI

protocol PurchaseViewPresenter: AnyObject{
    func setPurchaseParticapantAmount(phoneNumber: String, amount: Int)
    func addPurchaseParticipant(name: String,phoneNumber: String)
    func deletePurchaseParticipant(phoneNumber: String)
    func splitEqualPurchase()
    func listParticipants() -> [PurchaseParticipant]
    func getPurchase() -> Purchase
    func isEditable() -> Bool
    func updatePurchase(name: String, amount: Int, emoji: String, draft: Bool, created_at: Date)
    func action() // save/ok
    func viewDidLoad() // готовность view
}

class PurchasePresenter: PurchaseViewPresenter{
    
    weak var view: PurchaseView?
    var router: RouterProtocol
    var participants: [PurchaseParticipant]
    var phoneNumbers: [String: Bool]
    
    // Если purchase_id == 0 то покупка еще не создана
    // По умолчанию draft = true, то есть покупка черновик (счета не выставлены)
    var purchase: Purchase // стейт покупки на экране
    var actualPurchase: Purchase // стейт покупки на сервере
    var viewMode: ViewMode // режиме открытия view
    
    required init(router: RouterProtocol, purchase_id : Int = 0, mode: ViewMode){
        self.participants =  [PurchaseParticipant]()
        self.phoneNumbers =  [String: Bool]()
        self.router = router
        self.purchase = Purchase(id: purchase_id)
        self.actualPurchase = Purchase(id: purchase_id)
        self.viewMode = mode
    }
    
    
    func addPurchaseParticipant(name: String, phoneNumber: String) {
        let number = phoneNumber.toDefaultPhoneFormat()
        if phoneNumbers[number] != nil && phoneNumbers[number]! {
            view?.onUnableAddPurchaseParticipant()
            return
        }
        
        participants.append(PurchaseParticipant(phoneNumber: number, name: name, amount: 0))
        phoneNumbers[number] = true
        view?.onUpdatePurchaseParticipants()
    }
    
    func deletePurchaseParticipant(phoneNumber: String) {
        var participant: PurchaseParticipant?
        for (index,p) in participants.enumerated(){
            if p.phoneNumber == phoneNumber{
                participant = p
                participants.remove(at: index)
                break
            }
        }
        
        if participant != nil{
            phoneNumbers[phoneNumber] = false
            view?.onUpdatePurchaseParticipants()
        }
    }
    
    func setPurchaseParticapantAmount(phoneNumber: String, amount: Int){
        for (index,p) in participants.enumerated(){
            if p.phoneNumber == phoneNumber{
                participants[index].amount = amount
                break
            }
        }
    }
    
    func listParticipants() -> [PurchaseParticipant] {
        return participants
    }
    
    func getPurchase() -> Purchase{
        return purchase
    }
    
    func isEditable() -> Bool{
        return actualPurchase.draft
    }
    
    func updatePurchase(name: String, amount: Int, emoji: String, draft: Bool, created_at: Date){
        purchase.name = name
        purchase.amount = amount
        purchase.emoji = emoji
        purchase.draft = draft
        purchase.created_at = created_at
    }
    
    // Разбиением суммы покупки в равных долях между всеми участниками
    func splitEqualPurchase(){
        if participants.count == 0{
            return
        }
        let amount = Int(purchase.amount) / participants.count
        purchase.amount = amount * participants.count
        for (index,_) in participants.enumerated(){
                participants[index].amount = amount
        }
        view?.onUpdatePurchaseParticipants()
        view?.onUpdatePurchase()
    }
    
    // Сохранение покупки
    func action(){
        if !actualPurchase.draft{
            close()
            return
        }
        if !isValidPurchase(){
            self.view?.onInvalidPurchase()
            return
        }
        if purchase.id != 0{
            updatePurchase()
        } else {
            createPurchase()
        }
    }
    
    // Валидация покупки при редактировании
    func isValidPurchase() -> Bool{
        var amount = 0
        for p in participants{
            amount += p.amount
        }
        return amount != 0
    }
    
    // Закрытие view в зависимости от режима
    func close(){
        if self.viewMode == .present{
            self.router.dismissView()
        } else {
            self.router.popToRoot()
        }
    }
    
    // Создаем покупку
    func createPurchase(){
        var purchaseParticipants: [PurchaseParticipantCodable] = []
        for p in participants{
            purchaseParticipants.append(PurchaseParticipantCodable(phone: p.phoneNumber, amount: p.amount))
        }
        
        let newPurchase: CreateUpdatePurchaseCodable = CreateUpdatePurchaseCodable(name: purchase.name, description: purchase.description, emoji: purchase.emoji, participants: purchaseParticipants, draft: purchase.draft, created_at: purchase.created_at.ISO8601Format())
        router.sharePayPurchaseService.createPurchase(purchase: newPurchase, completion: { (result: Result<CreateUpdatePurchaseResponse, Error>) -> Void in
            switch result {
            case .success(let purchaseResponse):
                self.purchase.id = purchaseResponse.id
                DispatchQueue.main.async {
                    self.view?.onUpdatePurchase()
                    self.close()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onFailSavePurchase()
                }
            }
        })
    }
    
    // Редактируем покупку
    func updatePurchase(){
        var purchaseParticipants: [PurchaseParticipantCodable] = []
        for p in participants{
            purchaseParticipants.append(PurchaseParticipantCodable(phone: p.phoneNumber, amount: p.amount))
        }
        
        let newPurchase: CreateUpdatePurchaseCodable = CreateUpdatePurchaseCodable(name: purchase.name, description: purchase.description, emoji: purchase.emoji, participants: purchaseParticipants,  draft: purchase.draft, created_at: purchase.created_at.ISO8601Format())
        router.sharePayPurchaseService.updatePurchase(purchase: newPurchase, purchase_id: purchase.id, completion: { (result: Result<CreateUpdatePurchaseResponse, Error>) -> Void in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.actualPurchase = self.purchase
                    self.view?.onUpdatePurchase()
                    self.close()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onFailSavePurchase()
                }
            }
        })
    }
    
    // Подгружаем покупку
    func viewDidLoad(){
        if purchase.id != 0{
            router.sharePayPurchaseService.getPurchase(purchase_id: purchase.id, completion:{ (result: Result<PurchaseCodable, Error>) -> Void in
                switch result {
                case .success(let purchase):
                    // Загружаем участников покупки
                    var purchaseAmount: Int = 0
                    var newParticipants: [PurchaseParticipant] = []
                    if purchase.user_purchases != nil{
                        for p in purchase.user_purchases!{
                            
                            newParticipants.append(PurchaseParticipant(phoneNumber: p.user_phone,
                                                                       name: self.router.contactService.getNameByPhone(phoneNumber: p.user_phone, defaultName: p.user_phone),
                                                                       amount: p.amount))
                            purchaseAmount+=p.amount
                        }
                        self.participants = newParticipants
                    }
                
                    // Загружаем покупку
                    let newPurchase = Purchase(id: purchase.id, name: purchase.name, description: purchase.description ?? "", emoji: purchase.emoji, draft: purchase.draft, amount: purchaseAmount, created_at: (purchase.created_at ?? "").parseRFC3339Date())
                    self.purchase = newPurchase
                    self.actualPurchase = newPurchase
                    
                    DispatchQueue.main.async{
                        self.view?.onUpdatePurchaseParticipants()
                        self.view?.onUpdatePurchase()
                    }
                case .failure(_):
                    DispatchQueue.main.async{
                        self.view?.onFailGetPurchase()
                        self.router.dismissView()
                    }
                }
        })
        }
    }
}
