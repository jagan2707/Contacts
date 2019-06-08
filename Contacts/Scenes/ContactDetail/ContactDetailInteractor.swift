//
//  ContactDetailInteractor.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactDetailBusinessLogic {
    func doSomething(request: ContactDetail.Something.Request)
}

class ContactDetailInteractor: ContactDetailBusinessLogic {
    var presenter: ContactDetailPresentationLogic?
    fileprivate lazy var worker = ContactDetailWorker()
    
    // MARK: Business logic
    
    func doSomething(request: ContactDetail.Something.Request) {
        worker.doSomeWork()
        
        let response = ContactDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
