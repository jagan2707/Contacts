//
//  ContactViewController.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol ContactDisplayLogic: class {
    func displayContactList(viewModel: Contact.GetContacts.ViewModel)
    func displayAlert(contactListFailure: Contact.ContactListFailure)
}

class ContactViewController: UIViewController, ContactDisplayLogic {
    var interactor: ContactBusinessLogic?
    var router: ContactRoutingLogic?
    var contactList = [ContactInfo] ()
    @IBOutlet weak var contactTable: UITableView!
    @IBOutlet weak var groupButton: UIBarButtonItem!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
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
        getContacts()
        configure()
    }
    
    // MARK: Event handling
    
    func getContacts() {
        let request = Contact.GetContacts.Request()
        interactor?.getContacts(request: request)
    }
    
    // MARK: Display logic
    
    func displayContactList(viewModel: Contact.GetContacts.ViewModel) {
        self.contactList = viewModel.content
        DispatchQueue.main.async {
            self.contactTable.reloadData()
        }
    }
    
    func displayAlert(contactListFailure: Contact.ContactListFailure) {
        
        DispatchQueue.main.async {
            //self.removeActivityIndicator()
            let alert = UIAlertController(title: "Contacts", message: contactListFailure.alertString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            }))
            self.present(alert, animated: true, completion: {  })
        }
    }
    
    func setUpCell(cell: ContactCell,indexPath: IndexPath) {
        let contact = contactList[indexPath.row]
        var name = ""
        if let fname = contact.first_name {
            name = fname
        }
        if let lname = contact.last_name {
            name = name + lname
        }
        cell.contactName.text = name
        
        if contact.favorite == true {
            cell.favouriteImg.isHidden = false
        } else {
            cell.favouriteImg.isHidden = true
        }
        
    }
}

//MARK:UITableViewDataSource
extension ContactViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.contactList.count ;//isFavorite ? favoriteArray.count : countryArray.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ContactCell = (tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactCell?)!
        self.setUpCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

//MARK:UITableViewDelegate
extension ContactViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
}
