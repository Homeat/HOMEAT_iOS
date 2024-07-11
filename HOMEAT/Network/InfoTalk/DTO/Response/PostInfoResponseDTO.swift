//
//  PostInfoResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/1/24.
//

import Foundation

struct PostInfoResponseDTO: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let postNickName: String
    let title: String
    let content: String
    let tags: [String]?
    let love: Int?
    let view: Int?
    let commentNumber: Int?
    let setLove: Bool
    let status: String
    let infoPictureImages: [String]
    let profileImgUrl : String
    let infoTalkComments: [InfoTalkComments]
}

struct InfoTalkComments: Codable {
    let createdAt: String
    let updatedAt: String
    let commentId: Int
    let commentNickName: String
    let content: String
    let infoTalkReplies: [InfoTalkReplies]?
    
}

struct InfoTalkReplies: Codable {
    let createdAt: String
    let updatedAt: String
    let replyId: Int
    let replyNickName: String
    let content: String
}
