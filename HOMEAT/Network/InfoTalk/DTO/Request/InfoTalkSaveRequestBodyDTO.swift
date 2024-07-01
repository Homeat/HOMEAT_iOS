//
//  InfoTalkSaveRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/22/24.
//

import Foundation

struct InfoTalkSaveRequestBodyDTO: Codable {
    let title: String
    let content: String
    let tags: [String]
    let imgUrl: [Data]?
}
