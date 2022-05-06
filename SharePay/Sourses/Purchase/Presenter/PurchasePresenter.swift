//
//  PurchasePresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 18.04.2022.
//

import Foundation

protocol PurchaseViewPresenter: AnyObject{
    func addPurchaseParticipant(name: String,phoneNumber: String)
    func deletePurchaseParticipant(phoneNumber: String)
    func listParticipants() -> [PurchaseParticipant]
    func savePurchase(purchase: Purchase)
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
    
    func listParticipants() -> [PurchaseParticipant] {
        return participants
    }
    
    func savePurchase(purchase: Purchase){
        var purchaseParticipants: [PurchaseParticipantService] = []
        for p in participants{
            purchaseParticipants.append(PurchaseParticipantService(phone: p.phoneNumber, amount: p.amount))
        }
        
        let newPurchase: PurchaseService = PurchaseService(name: purchase.name, description: purchase.description, emoji: purchase.emoji, participants: purchaseParticipants)
        router.sharePayService.createPurchase(purchase: newPurchase, completion: { (result: Result<CreatePurchaseResponse, Error>) -> Void in
            switch result {
            case .success(_):
                self.router.popToRoot()
            case .failure(_):
                self.view?.onUnableAddPurchaseParticipant()
            }
        })
    }
    
    func ready(){
        purchase.id = 3 // ONLY FOR TEST
        if purchase.id != 0{
            router.sharePayService.getPurchase(purchase_id: purchase.id, completion:{ (result: Result<PurchaseWrapService, Error>) -> Void in
                switch result {
                case .success(let purchaseWrap):
                    let purchase: PurchaseService = purchaseWrap.purchase
                    // Загружаем участников покупки
                    var purchaseAmount: Int64 = 0
                    var newParticipants: [PurchaseParticipant] = []
                    for p in purchase.user_purchases{
                        newParticipants.append(PurchaseParticipant(phoneNumber: p.user_phone, name: self.getNameByPhone(phoneNumber: p.user_phone), amount: p.amount))
                        purchaseAmount+=p.amount
                    }
                    self.participants = newParticipants
                    self.view?.onUpdatePurchaseParticipants()
                
                    // TODO draft
                    let newPurchase = Purchase(id: purchase.id, name: purchase.name, description: purchase.description, emoji: purchase.emoji, draft: true, amount: purchaseAmount)
                    self.purchase = newPurchase
                    self.view?.onUpdatePurchase(purchase: self.purchase)
                case .failure(_):
                    self.view?.onFailGetPurchase()
                    self.router.popToRoot() // TODO
                }
        })
        }
    }
    
    private func getNameByPhone(phoneNumber: String) -> String{
        // TODO
        return phoneNumber
    }
    
}
