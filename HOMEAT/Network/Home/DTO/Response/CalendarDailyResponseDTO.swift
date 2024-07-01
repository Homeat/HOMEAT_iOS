//
//  CalendarResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/28/24.
//

import Foundation

struct CalendarDailyResponseDTO: Codable {
    let date : String
    let todayJipbapPrice : Int?
    let todayOutPrice : Int?
    let remainingGoal : Int?
    let message : String
}
