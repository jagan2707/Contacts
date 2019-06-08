//
//  ContactDetailPresenter.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactDetailPresentationLogic {
    func presentSomething(response: ContactDetail.Something.Response)
}

class ContactDetailPresenter: ContactDetailPresentationLogic {
    weak var viewController: ContactDetailDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentSomething(response: ContactDetail.Something.Response) {
        let viewModel = ContactDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
