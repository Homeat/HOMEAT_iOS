//
//  PayAddResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/24/24.
//

import Foundation

struct PayAddResponseDTO : Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: String
}
