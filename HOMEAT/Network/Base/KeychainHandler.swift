//
//  KeychainHandler.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation
import SwiftKeychainWrapper

struct Credentials {
    var tokenName: String
    var tokenContent: String
}

struct KeychainHandler {
    static var shared = KeychainHandler()
    
    private let keychain = KeychainWrapper(serviceName: "HOMEAT", accessGroup: "HOMEAT.iOS")
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    private let providerTokenKey = "providerToken"
    
    var accessToken: String {
        get { keychain.string(forKey: accessTokenKey) ?? "" }
        set { keychain.set(newValue, forKey: accessTokenKey) }
    }
    
    var refreshToken: String {
        get { keychain.string(forKey: refreshTokenKey) ?? "" }
        set { keychain.set(newValue, forKey: refreshTokenKey) }
    }
    
    var providerToken: String {
        get { keychain.string(forKey: providerTokenKey) ?? "" }
        set { keychain.set(newValue, forKey: providerTokenKey) }
    }
}
