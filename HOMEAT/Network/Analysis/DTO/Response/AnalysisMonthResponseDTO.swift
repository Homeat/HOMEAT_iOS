//
//  AnalysisMonthResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/5/24.
//

import Foundation

struct AnalysisMonthResponseDTO: Codable {
    let jipbapMonthPrice : Int
    let jipbapMonthOutPrice : Int
    let jipbapRatio : Double
    let outRatio : Double
    let savePercent : String
}
