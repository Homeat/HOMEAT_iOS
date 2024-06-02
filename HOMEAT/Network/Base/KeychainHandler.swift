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
    private let kakaoUserIDKey = "kakaoUserID"
    private let providerTokenKey = "providerToken"
    
    var accessToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: accessTokenKey) ?? "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsInVzZXJJZCI6NjcsImlhdCI6MTcxNzMzMDk1MywiZXhwIjoxNzE3MzM4MTUzfQ.6ALeiROwQLcWFWNFq6IZfDQdFB6JLCSxlC2heegQydk"
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    var refreshToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: refreshTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
    
    var kakaoUserID: String {
        get {
            return KeychainWrapper.standard.string(forKey: kakaoUserIDKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: kakaoUserIDKey)
        }
    }
    
    var providerToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: providerTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: providerTokenKey)
        }
    }
}

