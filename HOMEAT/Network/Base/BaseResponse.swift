//
//  BaseResponse.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: String
    let message: String
    let isSuccess: Bool
    let data: T?
}
