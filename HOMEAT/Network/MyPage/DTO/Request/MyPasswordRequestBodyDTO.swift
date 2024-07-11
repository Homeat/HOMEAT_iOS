//
//  MyPasswordRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/9/24.
//

import Foundation

struct MyPasswordRequestBodyDTO: Codable {
    let originPassword : String
    let newPassword: String
}
