//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by khalil.panahi
//

import Foundation

struct K {
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let title = "⚡️FlashChat"
    static let reusableCell = "ReusableCell"
    static let CellNibName = "MessageCell"

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    
}
