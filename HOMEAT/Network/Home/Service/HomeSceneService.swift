//
//  HomeService.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/24/24.
//


import Foundation

protocol HomeSceneServiceProtocol {
    func homeInfo(completion: @escaping (NetworkResult<BaseResponse<HomeInfoResponseDTO>>) -> Void)
    func ocr(bodyDTO: OcrRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<OcrResponseDTO>>) -> Void)
    func payAdd(bodyDTO: PayAddRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func payEdit(bodyDTO: PayEditRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
                                                                        
}

final class HomeSceneService: APIRequestLoader<HomeSceneTarget>, HomeSceneServiceProtocol {
    func payEdit(bodyDTO: PayEditRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .payEdit(bodyDTO), responseData: BaseResponse<String?>.self, completion: completion)
    }
    
    func homeInfo(completion: @escaping (NetworkResult<BaseResponse<HomeInfoResponseDTO>>) -> Void) {
        fetchData(target: .homeInfo,
                  responseData: BaseResponse<HomeInfoResponseDTO>.self, completion: completion)
    }
    func ocr(bodyDTO: OcrRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<OcrResponseDTO>>) -> Void) {
        fetchData(target: .ocr(bodyDTO),
                  responseData: BaseResponse<OcrResponseDTO>.self, completion: completion)
    }
    func payAdd(bodyDTO: PayAddRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .payAdd(bodyDTO),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
}
