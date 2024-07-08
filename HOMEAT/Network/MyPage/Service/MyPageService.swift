//
//  MyPageService.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/7/24.
//

import Foundation

protocol MyPageServiceProtocol {
    func mypage(completion: @escaping (NetworkResult<BaseResponse<MyPageResponseDTO>>) -> Void)
    func mypageEdit(bodyDTO: MyPageEditRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func mypageProfile(bodyDTO: ProfileEditRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func mypageDetail(completion: @escaping (NetworkResult<BaseResponse<MyPageDetailResponseDTO>>) -> Void)
    func myProfileDelete(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
}

final class MyPageService: APIRequestLoader<MyPageTarget>, MyPageServiceProtocol {
    func myProfileDelete(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .myProfileDelete, responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func mypageDetail(completion: @escaping (NetworkResult<BaseResponse<MyPageDetailResponseDTO>>) -> Void) {
        fetchData(target: .mypageDetail, responseData: BaseResponse<MyPageDetailResponseDTO>.self, completion: completion)
    }
    
    func mypage(completion: @escaping (NetworkResult<BaseResponse<MyPageResponseDTO>>) -> Void) {
        fetchData(target: .mypage, responseData: BaseResponse<MyPageResponseDTO>.self, completion: completion)
    }
    
    func mypageEdit(bodyDTO: MyPageEditRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .mypageEdit(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)

    }
    
    func mypageProfile(bodyDTO: ProfileEditRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .mypageProfile(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
}
