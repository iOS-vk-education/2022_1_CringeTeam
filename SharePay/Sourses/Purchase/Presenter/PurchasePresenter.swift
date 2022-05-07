//
//  PurchasePresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 18.04.2022.
//

import Foundation
import ContactsUI

protocol PurchaseViewPresenter: AnyObject{
    func setPurchaseParticapantAmount(phoneNumber: String, amount: Int64)
    func addPurchaseParticipant(name: String,phoneNumber: String)
    func deletePurchaseParticipant(phoneNumber: String)
    func splitEqualPurchase()
    func listParticipants() -> [PurchaseParticipant]
    func getPurchase() -> Purchase
    func updatePurchase(name: String, amount: Int64, emoji: String, draft: Bool)
    func savePurchase()
    func ready() // after viewDidLoad
}

class PurchasePresenter: PurchaseViewPresenter{
    
    weak var view: PurchaseView?
    var router: RouterProtocol
    var participants: [PurchaseParticipant]
    var phoneNumbers: [String: Bool]
    // Если purchase_id == 0 то покупка еще не создана
    // По умолчанию draft = true, то есть покупка черновик (счета не выставлены)
    var purchase: Purchase
    
    required init(view: PurchaseView, router: RouterProtocol, purchase_id : Int64 = 0){
        self.view = view
        self.participants =  [PurchaseParticipant]()
        self.phoneNumbers =  [String: Bool]()
        self.router = router
        self.purchase = Purchase(id: purchase_id)
    }
    
    
    func addPurchaseParticipant(name: String, phoneNumber: String) {
        if phoneNumbers[phoneNumber] != nil && phoneNumbers[phoneNumber]! {
            view?.onUnableAddPurchaseParticipant()
            return
        }
        
        participants.append(PurchaseParticipant(phoneNumber: phoneNumber, name: name, amount: 0))
        phoneNumbers[phoneNumber] = true
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
    
    func setPurchaseParticapantAmount(phoneNumber: String, amount: Int64){
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
    
    func updatePurchase(name: String, amount: Int64, emoji: String, draft: Bool){
        purchase.name = name
        purchase.amount = amount
        purchase.emoji = emoji
        purchase.draft = draft
    }
    
    func splitEqualPurchase(){
        if participants.count == 0{
            return
        }
        let amount = Int(purchase.amount) / participants.count
        purchase.amount = Int64(amount) * Int64(participants.count)
        for (index,_) in participants.enumerated(){
                participants[index].amount = Int64(amount)
        }
        view?.onUpdatePurchaseParticipants()
        view?.onUpdatePurchase()
    }
    
    func savePurchase(){
        var purchaseParticipants: [PurchaseParticipantService] = []
        for p in participants{
            purchaseParticipants.append(PurchaseParticipantService(phone: p.phoneNumber, amount: p.amount))
        }
        
        let newPurchase: PurchaseService = PurchaseService(name: purchase.name, description: purchase.description, emoji: purchase.emoji, participants: purchaseParticipants)
        router.sharePayPurchaseService.createPurchase(purchase: newPurchase, completion: { (result: Result<CreatePurchaseResponse, Error>) -> Void in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.router.popToRoot()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onUnableAddPurchaseParticipant()
                }
            }
        })
    }
    
    func ready(){
        if purchase.id != 0{
            router.sharePayPurchaseService.getPurchase(purchase_id: purchase.id, completion:{ (result: Result<PurchaseWrapService, Error>) -> Void in
                switch result {
                case .success(let purchaseWrap):
                    let purchase: PurchaseService = purchaseWrap.purchase
                    
                    // Загружаем участников покупки
                    var purchaseAmount: Int64 = 0
                    var newParticipants: [PurchaseParticipant] = []
                    for p in purchase.user_purchases{
                        
                        newParticipants.append(PurchaseParticipant(phoneNumber: p.user_phone,
                                                                   name: self.router.contactService.getNameByPhone(phoneNumber: p.user_phone, defaultName: p.user_phone),
                                                                   amount: p.amount))
                        purchaseAmount+=p.amount
                    }
                    self.participants = newParticipants
                
                    // Загружаем покупку
                    let newPurchase = Purchase(id: purchase.id, name: purchase.name, description: purchase.description, emoji: purchase.emoji, draft: true, amount: purchaseAmount) // TODO draft
                    self.purchase = newPurchase
                    
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
