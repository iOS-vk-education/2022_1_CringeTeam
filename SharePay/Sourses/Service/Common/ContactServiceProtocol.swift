//
//  ContactServiceProtocol.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 07.05.2022.
//

import Foundation
import ContactsUI

protocol ContactServiceProtocol: AnyObject{
    func getNameByPhone(phoneNumber: String, defaultName: String) -> String
}


class ContactService: ContactServiceProtocol {
    
    func getNameByPhone(phoneNumber: String, defaultName: String) -> String{
        let store = CNContactStore()
        var name: String = defaultName
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        let phone: String = contact.phoneNumbers.first?.value.stringValue ?? ""
                        if phone==phoneNumber{
                            name = contact.givenName
                        }
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
        return name
    }
    
}
