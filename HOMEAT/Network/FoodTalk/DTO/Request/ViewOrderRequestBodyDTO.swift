//
//  ViewOrderRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 6/15/24.
//

import Foundation

struct ViewOrderRequestBodyDTO: Codable {
    let search: String
    let tag: String
    let id: Int
    let view: Int
}
