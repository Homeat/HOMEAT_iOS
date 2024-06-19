//
//  CommentRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 이지우 on 5/26/24.
//

import Foundation

struct CommentWriteRequestBodyDTO: Codable {
    let id: Int
    let content: String
}
