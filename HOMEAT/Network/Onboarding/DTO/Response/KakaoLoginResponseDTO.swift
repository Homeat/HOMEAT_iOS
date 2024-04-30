//
//  KakaoLoginResponseDTO.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation

struct KakaoLoginResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String
}
