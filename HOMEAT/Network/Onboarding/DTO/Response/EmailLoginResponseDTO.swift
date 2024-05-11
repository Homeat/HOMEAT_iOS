//
//  EmailLoginResponseDTO.swift
//  HOMEAT
//
//  Created by 강석호 on 5/8/24.
//

import Foundation

struct EmailLoginResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
}
