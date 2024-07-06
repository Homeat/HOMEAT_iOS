//
//  WeekLookService.swift
//  HOMEAT
//
//  Created by 김민솔 on 5/11/24.
//

import Foundation

protocol WeekLookServiceProtocol {
    func weekLookReport(queryDTO: WeekLookRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<[WeekLookResponseDTO]>>) -> Void)
    func weekLookBadge(completion: @escaping (NetworkResult<BaseResponse<WeekBadgeResponseDTO>>) -> Void)
}

// 서비스 클래스 정의
final class WeekLookService: APIRequestLoader<WeekLookTarget>, WeekLookServiceProtocol {
    func weekLookBadge(completion: @escaping (NetworkResult<BaseResponse<WeekBadgeResponseDTO>>) -> Void) {
        fetchData(target: .weekBadgeInfo, responseData: BaseResponse<WeekBadgeResponseDTO>.self, completion: completion)
    }
    
    func weekLookReport(queryDTO: WeekLookRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<[WeekLookResponseDTO]>>) -> Void) {
        fetchData(target: .weekLook(queryDTO), responseData: BaseResponse<[WeekLookResponseDTO]>.self, completion: completion)
    }
}
