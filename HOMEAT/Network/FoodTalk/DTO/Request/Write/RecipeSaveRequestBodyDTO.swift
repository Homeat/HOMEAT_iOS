//
//  RecipeSaveRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 5/26/24.
//

import Foundation

struct RecipeSaveRequestBodyDTO : Codable {
    let id: Int
    let recipe: String
    let ingredient: String
    let tip: String
    let files: [Data]?
}
