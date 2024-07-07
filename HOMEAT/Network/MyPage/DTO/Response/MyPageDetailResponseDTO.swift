//
//  MyPageDetailResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/8/24.
//

import Foundation

struct MyPageDetailResponseDTO: Codable {
    let email : String
    let nickname: String
    let profileImgUrl : String
    let gender : String
    let birth: String
    let income: Int
    let address : [AddressResponseDTO]
}
