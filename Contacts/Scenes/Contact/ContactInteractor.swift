//
//  ContactInteractor.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactBusinessLogic {
    func getContacts(request: Contact.GetContacts.Request)
}

class ContactInteractor: ContactBusinessLogic {
    var presenter: ContactPresentationLogic?
    fileprivate lazy var worker = ContactWorker()
    
    // MARK: Business logic
    
    func getContacts(request: Contact.GetContacts.Request) {
        
        worker.getContactList(request: request, onSuccess: { contactList in
            self.presenter?.presentContacts(response: Contact.GetContacts.Response(result: contactList   ))
        }) { failureError in
            self.presenter?.presentAlert(response: failureError)
        }
    }
}

