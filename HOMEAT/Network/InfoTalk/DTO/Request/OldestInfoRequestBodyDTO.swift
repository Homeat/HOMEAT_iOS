//
//  OldestInfoRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation

struct OldestInfoRequestBodyDTO: Codable {
    let search: String
    let oldestInfoTalkId: Int
}
