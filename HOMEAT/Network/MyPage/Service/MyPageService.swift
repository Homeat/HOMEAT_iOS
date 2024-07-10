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
    func myPageWithDraw(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func myPageReactivate(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func changePassword(bodyDTO: MyPasswordRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func myNicknameExist(bodyDTO: NicknameRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func myPageLogout(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
}

final class MyPageService: APIRequestLoader<MyPageTarget>, MyPageServiceProtocol {
    func myPageLogout(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .mypageLogout, responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func myNicknameExist(bodyDTO: NicknameRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .myNicknameExist(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func changePassword(bodyDTO: MyPasswordRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .myPassword(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
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
    
    func myPageWithDraw(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .myPageWithDraw, responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func myPageReactivate(completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .myPageReactivate, responseData: BaseResponse<Data>.self, completion: completion)
    }
}
