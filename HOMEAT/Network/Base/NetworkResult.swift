//
//  NetworkResult.swift
//  HOMEAT
//
//  Created by 강석호 on 4/11/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
