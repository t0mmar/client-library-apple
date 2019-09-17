//
//  Credentials.swift
//  PIALibrary
//
//  Created by Davide De Rosa on 10/1/17.
//  Copyright © 2017 London Trust Media. All rights reserved.
//

import Foundation

/// The account credentials.
public struct Credentials {

    /// The username, typically a number prefixed with "p".
    public let username: String
    
    /// The password.
    public let password: String
    
    /// The email.
    public let email: String
    
    /// True if this is a reseller
    public let isReseller: Bool
    
    /// :nodoc:
    public init(username: String, password: String, isReseller: Bool = false) {
        self.username = username
        self.password = password
        self.email = ""
        self.isReseller = isReseller
    }
    
    public init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
        self.isReseller = true
    }
}

public extension Credentials {
    
    func toJSONDictionary() -> [String: Any] {
        return ["username":username, "password": password]
    }
    
    func resellerToken() -> String {
        return isReseller ? username + password : ""
    }

}
