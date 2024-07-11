//
//  ViewInfoResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation
struct ViewInfoResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let pageIdx: Int
    let pageSize: Int
    let hasNext: Bool
    let data: [InfoTalk]
}

struct InfoTalk: Codable {
    let infoTalkId: Int
    let createdAt: String
    let updatedAt: String
    let title: String
    let content: String
    let url: String
    let love: Int?
    let view: Int?
    let commentNumber: Int?
}
