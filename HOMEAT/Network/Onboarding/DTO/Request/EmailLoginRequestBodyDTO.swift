//
//  EmailLoginRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 강석호 on 5/8/24.
//

import Foundation

struct EmailLoginRequestBodyDTO: Codable {
    let email: String
    let password: String
}
