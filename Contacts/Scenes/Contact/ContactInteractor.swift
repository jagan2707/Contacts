//
//  ContactInteractor.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactBusinessLogic {
    func doSomething(request: Contact.Something.Request)
}

class ContactInteractor: ContactBusinessLogic {
    var presenter: ContactPresentationLogic?
    fileprivate lazy var worker = ContactWorker()
    
    // MARK: Business logic
    
    func doSomething(request: Contact.Something.Request) {
        worker.doSomeWork()
        
        let response = Contact.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
