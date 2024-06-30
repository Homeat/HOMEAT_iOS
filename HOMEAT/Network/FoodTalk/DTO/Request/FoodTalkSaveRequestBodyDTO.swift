//
//  FoodTalkSaveRequestDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 5/25/24.
//

import Foundation

struct FoodTalkSaveRequestBodyDTO: Codable {
    let name: String
    let memo: String
    let tag: String
    let foodPictures: [Data]?
    let foodRecipeRequest: [foodRecipeDTOS]
}

struct foodRecipeDTOS: Codable {
    let recipe: String
    let ingredient: String
    let recipePicture: Data?
}


