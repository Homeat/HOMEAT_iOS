//
//  HTTPHeaderField.swift
//  HOMEAT
//
//  Created by 강석호 on 4/11/24.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case accessToken = "accessToken"
    case refreshtoken = "refreshtoken"
    case providerToken = "X-Provider-Token"
}

enum HTTPHeaderFieldValue: String {
    case json = "Application/json"
    case multipartformData = "multipart/form-data"
    case accessToken
}

enum HTTPHeaderType {
    case plain
    case providerToken
    case hasToken
    case refreshToken
}

@frozen
enum Authorization {
    case authorization
    case unauthorization
    case socialAuthorization
    case reAuthorization
    case emailAuthorization
}
