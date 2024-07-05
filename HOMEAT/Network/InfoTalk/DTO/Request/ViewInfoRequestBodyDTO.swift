//
//  ViewInfoRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation

struct ViewInfoRequestBodyDTO: Codable {
    let search: String
    let id: Int
    let view: Int
}
