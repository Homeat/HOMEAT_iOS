//
//  FoodTalkService.swift
//  HOMEAT
//
//  Created by 이지우 on 5/25/24.
//

import Foundation

protocol FoodTalkServiceProtocol {
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void)
}

final class FoodTalkService: APIRequestLoader<FoodTalkTarget>, FoodTalkServiceProtocol {
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void) {
        fetchData(target: .foodTalkSave(bodyDTO), responseData: BaseResponse<Int>.self, completion: completion)
    }
}

