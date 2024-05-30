//
//  FoodTalkService.swift
//  HOMEAT
//
//  Created by 이지우 on 5/25/24.
//

import Foundation

protocol FoodTalkServiceProtocol {
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void)
    
    func replyWrite(bodyDTO: ReplyWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func recipeSave(bodyDTO: RecipeSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func love(bodyDTO: LoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func deleteLove(bodyDTO: DeleteLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func commentWrite(bodyDTO: CommentWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func checkOne(bodyDTO: CheckOneRequestBodyDTO, completion: @escaping (NetworkResult<CheckOneResponseDTO>) -> Void)
    
    func latestOrder(bodyDTO: LatestOrderRequestBodyDTO, completion: @escaping (NetworkResult<LatestOrderResponseDTO>) -> Void)
    
    func loveOrder(bodyDTO: LoveOrderRequestBodyDTO, completion: @escaping (NetworkResult<LoveOrderResponseDTO>) -> Void)
}

final class FoodTalkService: APIRequestLoader<FoodTalkTarget>, FoodTalkServiceProtocol {
    //게시글 저장
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void) {
        fetchData(target: .foodTalkSave(bodyDTO), responseData: BaseResponse<Int>.self, completion: completion)
    }
    
    //대댓글작성
    func replyWrite(bodyDTO: ReplyWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .replyWrite(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //레시피 저장
    func recipeSave(bodyDTO: RecipeSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .recipeSave(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //공감추가
    func love(bodyDTO: LoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .love(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //공감삭제
    func deleteLove(bodyDTO: DeleteLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .deleteLove(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //댓글작성
    func commentWrite(bodyDTO: CommentWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .commentWrite(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //게시글 1개 조회
    func checkOne(bodyDTO: CheckOneRequestBodyDTO, completion: @escaping (NetworkResult<CheckOneResponseDTO>) -> Void) {
        fetchData(target: .checkOne(_bodyDTO: bodyDTO), responseData: CheckOneResponseDTO.self, completion: completion)
    }
    
    
    //최신순 게시글 조회
    func latestOrder(bodyDTO: LatestOrderRequestBodyDTO, completion: @escaping (NetworkResult<LatestOrderResponseDTO>) -> Void) {
        fetchData(target: .latestOrder(bodyDTO), responseData: LatestOrderResponseDTO.self, completion: completion)
    }
    
    //공감순 게시글 조회
    func loveOrder(bodyDTO: LoveOrderRequestBodyDTO, completion: @escaping (NetworkResult<LoveOrderResponseDTO>) -> Void) {
        fetchData(target: .loveOrder(bodyDTO), responseData: LoveOrderResponseDTO.self, completion: completion)
    }
}

