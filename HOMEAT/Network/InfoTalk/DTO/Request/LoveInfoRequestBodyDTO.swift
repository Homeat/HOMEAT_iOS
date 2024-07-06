//
//  LoveInfoRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation

struct LoveInfoRequestBodyDTO: Codable {
    let search: String
    let id: Int
    let love: Int
}
