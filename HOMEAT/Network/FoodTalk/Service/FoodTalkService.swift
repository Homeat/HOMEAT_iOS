//
//  FoodTalkService.swift
//  HOMEAT
//
//  Created by 이지우 on 5/25/24.
//

import Foundation

protocol FoodTalkServiceProtocol {
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func replyReport(bodyDTO: ReplyReportRequestBodyDTO,completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func postReport(bodyDTO: PostReportRequestBodyDTO,completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func commentReport(bodyDTO: CommentReportRequestBodyDTO,completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func replyWrite(bodyDTO: ReplyWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func recipeSave(bodyDTO: RecipeSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func love(bodyDTO: LoveRequestBodyDTO, completion: @escaping
        (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func deleteLove(bodyDTO: DeleteLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func commentWrite(bodyDTO: CommentWriteRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func checkOne(bodyDTO: CheckOneRequestBodyDTO, completion: @escaping (NetworkResult<CheckOneResponseDTO>) -> Void)
    
    func viewOrder(bodyDTO: ViewOrderRequestBodyDTO, completion: @escaping (NetworkResult<ViewOrderResponseDTO>) -> Void)
    
    func oldestOrder(bodyDTO: OldestOrderRequestBodyDTO, completion: @escaping (NetworkResult<OldestOrderResponseDTO>) -> Void)
    
    func loveOrder(bodyDTO: LoveOrderRequestBodyDTO, completion: @escaping (NetworkResult<LoveOrderResponseDTO>) -> Void)
    
    func latestOrder(bodyDTO: LatestOrderRequestBodyDTO, completion: @escaping (NetworkResult<LatestOrderResponseDTO>) -> Void)
    
    func deleteReply(bodyDTO: DeleteReplyRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func deletePost(bodyDTO: DeletePostRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    
    func deleteComment(bodyDTO: DeleteCommentRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
}

final class FoodTalkService: APIRequestLoader<FoodTalkTarget>, FoodTalkServiceProtocol {
    //게시글 저장
    func foodTalkSave(bodyDTO: FoodTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .foodTalkSave(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //대댓글 신고
    func replyReport(bodyDTO: ReplyReportRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .replyReport(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //게시글 신고
    func postReport(bodyDTO: PostReportRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .postReport(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //댓글 신고
    func commentReport(bodyDTO: CommentReportRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .commentReport(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
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
        fetchData(target: .checkOne(bodyDTO), responseData: CheckOneResponseDTO.self, completion: completion)
    }
    
    //조회순 게시글 조회
    func viewOrder(bodyDTO: ViewOrderRequestBodyDTO, completion: @escaping (NetworkResult<ViewOrderResponseDTO>) -> Void) {
        fetchData(target: .viewOrder(bodyDTO), responseData: ViewOrderResponseDTO.self, completion: completion)
    }
    
    //오래된순 게시글 조회
    func oldestOrder(bodyDTO: OldestOrderRequestBodyDTO, completion: @escaping (NetworkResult<OldestOrderResponseDTO>) -> Void) {
        fetchData(target: .oldestOrder(_bodyDTO: bodyDTO), responseData: OldestOrderResponseDTO.self, completion: completion)
    }
    
    //최신순 게시글 조회
    func latestOrder(bodyDTO: LatestOrderRequestBodyDTO, completion: @escaping (NetworkResult<LatestOrderResponseDTO>) -> Void) {
        fetchData(target: .latestOrder(bodyDTO), responseData: LatestOrderResponseDTO.self, completion: completion)
    }
    
    //공감순 게시글 조회
    func loveOrder(bodyDTO: LoveOrderRequestBodyDTO, completion: @escaping (NetworkResult<LoveOrderResponseDTO>) -> Void) {
        fetchData(target: .loveOrder(bodyDTO), responseData: LoveOrderResponseDTO.self, completion: completion)
    }
    
    //대댓글 삭제
    func deleteReply(bodyDTO: DeleteReplyRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .deleteReply(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //게시글 삭제
    func deletePost(bodyDTO: DeletePostRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .deletePost(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    //댓글 삭제
    func deleteComment(bodyDTO: DeleteCommentRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .deleteComment(_bodyDTO: bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
}

