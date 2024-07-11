//
//  AddressDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/8/24.
//

import Foundation

struct AddressResponseDTO: Codable {
    let addressId: Int
    let code: Int?
    let fullNm: String?
    let emdNm: String?
}
