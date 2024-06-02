//
//  PayAddResponseDTO.swift
//  HOMEAT
//
//  Created by 강삼고 on 6/2/24.
//

import Foundation

struct PayAddResponseDTO : Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: String
}
