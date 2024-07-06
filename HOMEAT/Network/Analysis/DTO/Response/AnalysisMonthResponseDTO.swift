//
//  AnalysisMonthResponseDTO.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/5/24.
//

import Foundation

struct AnalysisMonthResponseDTO: Codable {
    let monthZeroExpense : Int?
    let month_jipbap_price : Int?
    let month_out_price : Int?
    let jipbap_ratio : Int?
    let out_ratio : Int?
    let save_percent : Double?
}
