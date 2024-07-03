//
//  LoveInfoResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation
struct LoveInfoResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let pageIdx: Int
    let pageSize: Int
    let hasNext: Bool
    let data: [InfoTalk]
}
