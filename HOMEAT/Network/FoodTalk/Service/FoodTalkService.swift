//
//  FoodTalkService.swift
//  HOMEAT
//
//  Created by 이지우 on 5/25/24.
//

import Foundation

protocol FoodTalkServiceProtocol {
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void)
    
    func recipeSave(bodyDTO: RecipeSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func commentWrite(bodyDTO: CommentWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func replyWrite(bodyDTO: ReplyWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func love(bodyDTO: LoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
}

final class FoodTalkService: APIRequestLoader<FoodTalkTarget>, FoodTalkServiceProtocol {
    //게시글 저장
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void) {
        fetchData(target: .foodTalkSave(bodyDTO), responseData: BaseResponse<Int>.self, completion: completion)
    }
    
    //레시피 저장
    func recipeSave(bodyDTO: RecipeSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .recipeSave(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //댓글작성
    func commentWrite(bodyDTO: CommentWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .commentWrite(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //대댓글작성
    func replyWrite(bodyDTO: ReplyWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .replyWrite(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //공감추가
    func love(bodyDTO: LoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .love(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
}

