//
//  AnalysisWeekResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/5/24.
//

import Foundation

struct AnalysisWeekResponseDTO: Codable {
    let jipbap_save: Int?
    let out_save: Int?
    let jipbap_average: Int?
    let week_jipbap_price: Int?
    let out_average: Int?
    let week_out_price: Int?
}
