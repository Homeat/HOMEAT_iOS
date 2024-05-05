//
//  AnalysisService.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation

protocol AnalysisServiceProtocol {
    func analysisMonth(bodyDTO: AnalysisMonthRequestDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisMonthResponseDTO>>) -> Void)
    func analysisWeek(bodyDTO: AnalysisWeekRequestDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisWeekResponseDTO>>) -> Void)
}

final class AnalysisService: APIRequestLoader<AnalysisTarget>, AnalysisServiceProtocol {
    func analysisMonth(bodyDTO: AnalysisMonthRequestDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisMonthResponseDTO>>) -> Void) {
        fetchData(target: .Month(bodyDTO), responseData: BaseResponse<AnalysisMonthResponseDTO>.self, completion: completion)
    }
    func analysisWeek(bodyDTO: AnalysisWeekRequestDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisWeekResponseDTO>>) -> Void) {
        fetchData(target: .Week(bodyDTO), responseData: BaseResponse<AnalysisWeekResponseDTO>.self, completion: completion)
    }
}
