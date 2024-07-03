//
//  LatestInfoRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation

struct LatestInfoRequestBodyDTO: Codable {
    let search: String
    let lastInfoTalkId: Int
}
