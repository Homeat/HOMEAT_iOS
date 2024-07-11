//
//  CheckOneResponseDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 5/30/24.
//

import Foundation

struct CheckOneResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let profileImgUrl: String
    let postNickName: String
    let name: String
    let memo: String
    let ingredient: String
    let tag: String
    let love: Int
    let view: Int
    let commentNumber: Int
    let setLove: Bool
    let status: String
    let foodPictureImages: [String]
    let foodTalkRecipes: [FoodTalkRecipe]
    let foodTalkComments: [FoodTalkComment]
}

// MARK: - FoodTalkRecipe
struct FoodTalkRecipe: Codable {
    let step: Int
    let recipe: String
    let ingredient: String?
    let tip: String?
    let foodRecipeImages: [String]
}

// MARK: - FoodTalkComment
struct FoodTalkComment: Codable {
    let createdAt: String
    let updatedAt: String
    let commentId: Int
    let commentNickName: String
    let content: String
    let status: String
    let foodTalkReplies: [FoodTalkReply]?
}

// MARK: - FoodTalkReply
struct FoodTalkReply: Codable {
    let createdAt: String
    let updatedAt: String
    let replyId: Int
    let replyNickName: String
    let content: String
    let status: String
}

