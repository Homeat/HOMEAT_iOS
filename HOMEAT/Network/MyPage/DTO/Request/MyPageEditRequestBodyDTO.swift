//
//  MyPageEditRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/8/24.
//

import Foundation

struct MyPageEditRequestBodyDTO: Codable {
    let email: String
    let nickname: String
    let addressId: Int
    let income : Int
}
