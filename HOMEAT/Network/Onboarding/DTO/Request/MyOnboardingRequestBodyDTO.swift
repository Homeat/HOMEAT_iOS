//
//  MyOnboardingRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/9/24.
//

import Foundation

struct MyOnboardingRequestBodyDTO: Codable {
    let nickname : String
    let gender: String
    let birth: String
    let adderessId : Int
    let income : Int
    let goalPrice: Int
}
