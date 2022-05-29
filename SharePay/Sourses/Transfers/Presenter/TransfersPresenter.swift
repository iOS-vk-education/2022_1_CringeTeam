//
//  TransfersPresenter.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 15.05.2022.
//

import Foundation
import UIKit


protocol TransfersViewPresenter: AnyObject{
    func listTransfers() -> [Transfer]
    func refresh()
}

final class TransfersPresenter: TransfersViewPresenter{
    
    weak var view: TransfersView?
    var router: RouterProtocol
    var transfers: [Transfer]
    
    init(view: TransfersView, router: RouterProtocol){
        self.view = view
        self.router = router
        self.transfers = []
    }
    
    func listTransfers() -> [Transfer] {
        return transfers
    }
    
    func refresh(){
        router.sharePayPaymentService.listPayments(completion: { [weak self] (result: Result<[PaymentCodable], Error>) -> Void in
            switch result {
            case .success(let payments):
                
                self?.transfers = []
                for p in payments{
                    var phone = p.sender_phone
                    if phone == self?.router.authService.getPhone(){
                        phone = p.receiver_phone
                    }
                    
                    let name = self?.router.contactService.getNameByPhone(phoneNumber: phone,
                                                                         defaultName: phone) ?? ""
                    self?.transfers.append(Transfer(amount: p.amount,
                                              phone: p.sender_phone,
                                              name: name,
                                              created_at: p.created_at.parseRFC3339Date()))
                }
                
                self?.transfers.sort(by: { (a: Transfer, b: Transfer) -> Bool in
                    return a.created_at > b.created_at
                })
                
                DispatchQueue.main.async {
                    self?.view?.onSuccesssTransfersLoad()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view?.onFailedTransfersLoad()
                }
            }
        })
    }

}
