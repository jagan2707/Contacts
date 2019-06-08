//
//  ContactPresenter.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactPresentationLogic {
    func presentContacts(response: Contact.GetContacts.Response)
    func presentAlert(response: Contact.ContactListFailure)

}

class ContactPresenter: ContactPresentationLogic {
    weak var viewController: ContactDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentContacts(response: Contact.GetContacts.Response) {
        
       let viewModel  = Contact.GetContacts.ViewModel(content: response.result)
        viewController?.displayContactList(viewModel: viewModel)
    }
    
    func presentAlert(response: Contact.ContactListFailure){
        viewController?.displayAlert(contactListFailure: response)
    }
}
