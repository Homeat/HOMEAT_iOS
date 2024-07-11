//
//  HomeInfoResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/24/24.
//

import Foundation

struct HomeInfoResponseDTO : Codable {
    let nickname : String
    let targetMoney : Int
    let beforeSavingPercent : Int
    let remainingMoney : Int
    let badgeImgUrl : String
    let remainingPercent : Int
    let beforeWeek : Int
    let message : String
}
