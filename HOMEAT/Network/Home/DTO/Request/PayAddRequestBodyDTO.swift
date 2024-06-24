//
//  PayAddRequestBodyDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/24/24.
//
import Foundation

struct PayAddRequestBodyDTO: Codable {
    let money : Int?
    let type : String?
    let memo : String?
    let url : [Data]?
}
