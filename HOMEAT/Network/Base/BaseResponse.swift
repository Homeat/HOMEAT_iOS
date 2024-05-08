//
//  BaseResponse.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let message: String
    let isSuccess: Bool
    let data: T?
}
