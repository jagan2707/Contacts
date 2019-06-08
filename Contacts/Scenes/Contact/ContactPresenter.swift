//
//  ContactPresenter.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactPresentationLogic {
    func presentSomething(response: Contact.Something.Response)
}

class ContactPresenter: ContactPresentationLogic {
    weak var viewController: ContactDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentSomething(response: Contact.Something.Response) {
        let viewModel = Contact.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
