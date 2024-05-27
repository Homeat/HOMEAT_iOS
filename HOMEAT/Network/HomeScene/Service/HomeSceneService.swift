//
//  HomeSceneService.swift
//  HOMEAT
//
//  Created by 강삼고 on 5/26/24.
//

import Foundation

protocol HomeSceneServiceProtocol {
    func homeInfo(completion: @escaping (NetworkResult<BaseResponse<HomeInfoResponseDTO>>) -> Void)
}

final class HomeSceneService: APIRequestLoader<HomeSceneTarget>, HomeSceneServiceProtocol {
    func homeInfo(completion: @escaping (NetworkResult<BaseResponse<HomeInfoResponseDTO>>) -> Void) {
        fetchData(target: .homeInfo,
                  responseData: BaseResponse<HomeInfoResponseDTO>.self, completion: completion)
    }
}
