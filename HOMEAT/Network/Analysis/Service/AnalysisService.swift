//
//  AnalysisService.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/3/24.
//

import Foundation

protocol AnalysisServiceProtocol {
    func analysisMonth(bodyDTO: AnalysisMonthRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisMonthResponseDTO>>) -> Void)
    func analysisWeek(bodyDTO: AnalysisWeekRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisWeekResponseDTO>>) -> Void)
    func analysisDetail(bodyDTO: AnalysisDetailRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisDetailResponseDTO>>) -> Void)
}

final class AnalysisService: APIRequestLoader<AnalysisTarget>, AnalysisServiceProtocol {
    func analysisDetail(bodyDTO: AnalysisDetailRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisDetailResponseDTO>>) -> Void) {
        fetchData(target: .Detail(bodyDTO), responseData: BaseResponse<AnalysisDetailResponseDTO>.self, completion: completion)
    }
    
    func analysisMonth(bodyDTO: AnalysisMonthRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisMonthResponseDTO>>) -> Void) {
        fetchData(target: .Month(bodyDTO), responseData: BaseResponse<AnalysisMonthResponseDTO>.self, completion: completion)
    }
    func analysisWeek(bodyDTO: AnalysisWeekRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<AnalysisWeekResponseDTO>>) -> Void) {
        fetchData(target: .Week(bodyDTO), responseData: BaseResponse<AnalysisWeekResponseDTO>.self, completion: completion)
    }
}
