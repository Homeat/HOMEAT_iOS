//
//  CalendarCheckResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/27/24.
//

import Foundation

struct CalendarCheckResponseDTO: Codable {
    let date: String
    let todayJipbapPricePercent : Int
    let todayOutPricePercent: Int
}
