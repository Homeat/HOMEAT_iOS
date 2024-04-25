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
}

enum ContentType: String {
    case json = "Application/json"
}
