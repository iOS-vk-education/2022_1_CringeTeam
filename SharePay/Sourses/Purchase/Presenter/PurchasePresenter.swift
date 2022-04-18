//
//  PurchasePresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 18.04.2022.
//

import Foundation

protocol PurchaseViewPresenter: AnyObject{
    init(view: PurchaseView)
    func addPurchaseParticipant(name: String,phoneNumber: String)
    func deletePurchaseParticipant(phoneNumber: String)
    func listParticipants() -> [PurchaseParticipant]
}

class PurchasePresenter: PurchaseViewPresenter{
    
    weak var view: PurchaseView?
    var participants: [PurchaseParticipant]
    var phoneNumbers: [String: Bool]
    
    required init(view: PurchaseView) {
        self.view = view
        self.participants =  [PurchaseParticipant]()
        self.phoneNumbers =  [String: Bool]()
    }
    
    func addPurchaseParticipant(name: String, phoneNumber: String) {
        if phoneNumbers[phoneNumber] != nil && phoneNumbers[phoneNumber]! {
            view?.onUnableAddPurchaseParticipant()
            return
        }
        
        participants.append(PurchaseParticipant(phoneNumber: phoneNumber, name: name, amount: 0))
        phoneNumbers[phoneNumber] = true
        view?.onAddPurchaseParticipant(name: name, phoneNumber: phoneNumber)
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
            view?.onDeletePurchaseParticipant()
        }
    }
    
    func listParticipants() -> [PurchaseParticipant] {
        return participants
    }
    
}
