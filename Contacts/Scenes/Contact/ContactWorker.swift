//
//  ContactWorker.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit


@objc protocol ContactWorkerDelegate: class {
    
    @objc optional func didDownloadContacts()
    @objc optional func didFailToDownloadContactsNoResponse()
    @objc optional func didFailToDownloadContactsEmptyResponse()
    @objc optional func didDownloadContactsProgress(progress: Float)
    @objc optional func didStartDownload()
}

class ContactWorker {
  
    static let shared: ContactWorker = ContactWorker()
    public weak var delegate: ContactWorkerDelegate? = nil
    static private let gojekBaseUrl: String             = "http://gojek-contacts-app.herokuapp.com"
    static private let gojekContactExtensionUrl: String = "/contacts.json"
    static private let didDownloadKey                   = "didDownloadGojekContactsKey"
    static public let alphabet: [String]                = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
    static private let didFailEmptyResponse = "No data available";
    static private let noResponse = "Please try again";

    private var isFetchingData: Bool  = false

    static public func gojekUrl() -> String {
        return ContactWorker.gojekBaseUrl + ContactWorker.gojekContactExtensionUrl
    }
    
    func getContactList(request: Contact.GetContacts.Request, onSuccess success: @escaping (_ result: [ContactInfo]) -> Void, onFailure failure: @escaping (_ loginFailure: Contact.ContactListFailure) -> Void) {
        

        let url = ContactWorker.gojekUrl()
        NetworkManager.shared.get(urlString: url, completionBlock: {(data: Data?) -> Void in
            
            if let d = data {
                var dataArr: [[String: Any]] = [[String: Any]]()
                
                // format contacts data to json
                do {
                    dataArr = try JSONSerialization.jsonObject(with: d, options: []) as! [[String: Any]]
                } catch {
                    failure(Contact.ContactListFailure(alertString: error.localizedDescription))
                }
                
                // empty data
                if dataArr.count == 0 {
                    self.isFetchingData = false
                    
                    failure(Contact.ContactListFailure(alertString: ContactWorker.didFailEmptyResponse))
                    self.delegate?.didFailToDownloadContactsEmptyResponse?() // failure due to empty data
                    return
                }
                
                let contactList = dataArr.map {
                    ContactInfo(from: $0 )
                }
                success(contactList)
                
            } else {
                // failure due to no data/no internet connection
                self.isFetchingData = false
                failure(Contact.ContactListFailure(alertString: ContactWorker.noResponse))
            }
            
        })

    }
}
