//
//  EmailSignUpResponseDTO.swift
//  HOMEAT
//
//  Created by 강석호 on 6/22/24.
//

import Foundation

struct EmailSignUpResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
}
