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
    func updatePurchase(name: String, amount: Int, emoji: String, draft: Bool)
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
    var viewMode: ViewMode
    
    required init(view: PurchaseView, router: RouterProtocol, purchase_id : Int = 0, mode: ViewMode){
        self.view = view
        self.participants =  [PurchaseParticipant]()
        self.phoneNumbers =  [String: Bool]()
        self.router = router
        self.purchase = Purchase(id: purchase_id)
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
    
    func updatePurchase(name: String, amount: Int, emoji: String, draft: Bool){
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
        purchase.amount = amount * participants.count
        for (index,_) in participants.enumerated(){
                participants[index].amount = amount
        }
        view?.onUpdatePurchaseParticipants()
        view?.onUpdatePurchase()
    }
    
    func savePurchase(){
        if !isValidPurchase(){
            self.view?.onInvalidPurchase()
            return
        }
        if purchase.id != 0{
            if purchase.draft{
                updatePurchase()
            }
        } else {
            createPurchase()
        }
    }
    
    func isValidPurchase() -> Bool{
        var amount = 0
        for p in participants{
            amount += p.amount
        }
        return amount != 0
    }
    
    func createPurchase(){
        var purchaseParticipants: [PurchaseParticipantCodable] = []
        for p in participants{
            purchaseParticipants.append(PurchaseParticipantCodable(phone: p.phoneNumber, amount: p.amount))
        }
        
        let newPurchase: CreateUpdatePurchaseCodable = CreateUpdatePurchaseCodable(name: purchase.name, description: purchase.description, emoji: purchase.emoji, participants: purchaseParticipants, draft: purchase.draft, created_at: purchase.created_at.formatted())
        router.sharePayPurchaseService.createPurchase(purchase: newPurchase, completion: { (result: Result<CreateUpdatePurchaseResponse, Error>) -> Void in
            switch result {
            case .success(let purchaseResponse):
                self.purchase.id = purchaseResponse.id
                DispatchQueue.main.async {
                    self.view?.onUpdatePurchase()
                    if self.viewMode == .present{
                        self.router.dismissView()
                    } else {
                        self.router.popToRoot()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onFailSavePurchase()
                }
            }
        })
    }
    
    func updatePurchase(){
        var purchaseParticipants: [PurchaseParticipantCodable] = []
        for p in participants{
            purchaseParticipants.append(PurchaseParticipantCodable(phone: p.phoneNumber, amount: p.amount))
        }
        
        let newPurchase: CreateUpdatePurchaseCodable = CreateUpdatePurchaseCodable(name: purchase.name, description: purchase.description, emoji: purchase.emoji, participants: purchaseParticipants,  draft: purchase.draft, created_at: purchase.created_at.formatted())
        router.sharePayPurchaseService.updatePurchase(purchase: newPurchase, purchase_id: purchase.id, completion: { (result: Result<CreateUpdatePurchaseResponse, Error>) -> Void in
            switch result {
            case .success(let purchaseResponse):
                DispatchQueue.main.async {
                    self.view?.onUpdatePurchase()
                    if self.viewMode == .present{
                        self.router.dismissView()
                    } else {
                        self.router.popToRoot()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.onFailSavePurchase()
                }
            }
        })
    }
    
    func ready(){
        if purchase.id != 0{
            router.sharePayPurchaseService.getPurchase(purchase_id: purchase.id, completion:{ (result: Result<PurchaseCodable, Error>) -> Void in
                switch result {
                case .success(let purchase):
                    // Загружаем участников покупки
                    var purchaseAmount: Int = 0
                    var newParticipants: [PurchaseParticipant] = []
                    for p in purchase.user_purchases{
                        
                        newParticipants.append(PurchaseParticipant(phoneNumber: p.user_phone,
                                                                   name: self.router.contactService.getNameByPhone(phoneNumber: p.user_phone, defaultName: p.user_phone),
                                                                   amount: p.amount))
                        purchaseAmount+=p.amount
                    }
                    self.participants = newParticipants
                
                    // Загружаем покупку
                    let newPurchase = Purchase(id: purchase.id, name: purchase.name, description: purchase.description, emoji: purchase.emoji, draft: purchase.draft, amount: purchaseAmount)
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
