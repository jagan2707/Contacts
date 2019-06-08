//
//  ContactViewController.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactDisplayLogic: class {
    func displaySomething(viewModel: Contact.Something.ViewModel)
}

class ContactViewController: UIViewController, ContactDisplayLogic {
    var interactor: ContactBusinessLogic?
    var router: ContactRoutingLogic?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ContactInteractor()
        let presenter = ContactPresenter()
        let router = ContactRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Configuration
    private func configure() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        configure()
    }
    
    // MARK: Event handling
    
    func doSomething() {
        let request = Contact.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: Display logic
    
    func displaySomething(viewModel: Contact.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
