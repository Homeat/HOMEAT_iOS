//
//  FindPasswordRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/10/24.
//

import Foundation

struct FindPasswordRequestBodyDTO: Codable {
    let email: String
    let newPassword: String
}
