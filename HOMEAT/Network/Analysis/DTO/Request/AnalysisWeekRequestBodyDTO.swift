//
//  AnalysisWeekRequestDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/5/24.
//

import Foundation

struct AnalysisWeekRequestBodyDTO: Codable {
    let input_year : String
    let input_month : String
    let input_day : String
}
