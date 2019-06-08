//
//  ContactModels.swift
//  Contacts
//
//  Created by jagadeesh on 8/6/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

enum Contact {
    // MARK: Use cases
    
    enum GetContacts {
        struct Request {
        }
        struct Response {
            var result: [ContactInfo]
        }
        struct ViewModel {
           var content: [ContactInfo]
        }
    }
    
    struct ContactListFailure
    {
        var alertString: String
    }
}
