//
//  EmailSignUpRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 강석호 on 6/22/24.
//

import Foundation

struct EmailSignUpRequestBodyDTO: Codable {
    let email: String
    let password: String
}
