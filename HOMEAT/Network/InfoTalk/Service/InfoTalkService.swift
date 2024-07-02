//
//  InfoTalkService.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/22/24.
//

import Foundation
import Alamofire
protocol InfoTalkServiceProtocol {
    func infoTalkSave(bodyDTO: InfoTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void)
    func latestInfo(queryDTO: LatestInfoRequestBodyDTO, completion: @escaping (NetworkResult<LatestInfoResponseDTO>) -> Void)
    func viewOrder(bodyDTO: ViewInfoRequestBodyDTO, completion: @escaping (NetworkResult<ViewInfoResponseDTO>) -> Void)
    func oldestOrder(bodyDTO: OldestInfoRequestBodyDTO, completion: @escaping (NetworkResult<OldestInfoResponseDTO>) -> Void)
    func loveOrder(bodyDTO: LoveInfoRequestBodyDTO, completion: @escaping (NetworkResult<LoveInfoResponseDTO>) -> Void)
    func postReport(queryDTO: PostInfoRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<PostInfoResponseDTO>>) -> Void)
    func commentWrite(bodyDTO: InfoCommentRequestBodyDTO, completion:
    @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func lovePost(bodyDTO: InfoLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
    func lovePostDelete(bodyDTO: InfoDeleteLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void)
}

final class InfoTalkService : APIRequestLoader<InfoTalkTarget>,InfoTalkServiceProtocol {
    func lovePostDelete(bodyDTO: InfoDeleteLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .postLoveDelete(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func lovePost(bodyDTO: InfoLoveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .postLove(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func commentWrite(bodyDTO: InfoCommentRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Data>>) -> Void) {
        fetchData(target: .commentReport(bodyDTO), responseData: BaseResponse<Data>.self, completion: completion)
    }
    
    func postReport(queryDTO: PostInfoRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<PostInfoResponseDTO>>) -> Void) {
        fetchData(target: .postReport(queryDTO), responseData: BaseResponse<PostInfoResponseDTO>.self, completion: completion)
    }
    
    func viewOrder(bodyDTO: ViewInfoRequestBodyDTO, completion: @escaping (NetworkResult<ViewInfoResponseDTO>) -> Void) {
        fetchData(target: .viewInfo(bodyDTO), responseData: ViewInfoResponseDTO.self, completion: completion)
    }

    func oldestOrder(bodyDTO: OldestInfoRequestBodyDTO, completion: @escaping (NetworkResult<OldestInfoResponseDTO>) -> Void) {
        fetchData(target: .oldestInfo(bodyDTO), responseData: OldestInfoResponseDTO.self, completion: completion)
    }
    
    func loveOrder(bodyDTO: LoveInfoRequestBodyDTO, completion: @escaping (NetworkResult<LoveInfoResponseDTO>) -> Void) {
        fetchData(target: .loveInfo(bodyDTO), responseData: LoveInfoResponseDTO.self, completion: completion)
    }

    func latestInfo(queryDTO: LatestInfoRequestBodyDTO, completion: @escaping (NetworkResult<LatestInfoResponseDTO>) -> Void) {
        fetchData(target: .latestInfo(queryDTO), responseData: LatestInfoResponseDTO.self, completion: completion)
    }
    
    func infoTalkSave(bodyDTO: InfoTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void) {
        fetchData(target: .infoTalkSave(bodyDTO), responseData: BaseResponse<Int>.self, completion: completion)
    }
    
}
