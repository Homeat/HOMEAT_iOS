//
//  HomeInfoResponseDTO.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/26/24.
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
