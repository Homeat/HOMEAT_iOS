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
    func latestInfo(bodyDTO: LatestInfoRequestBodyDTO, completion: @escaping (NetworkResult<LatestInfoResponseDTO>) -> Void)
    func viewOrder(bodyDTO: ViewInfoRequestBodyDTO, completion: @escaping (NetworkResult<ViewInfoResponseDTO>) -> Void)
    func oldestOrder(bodyDTO: OldestInfoRequestBodyDTO, completion: @escaping (NetworkResult<OldestInfoResponseDTO>) -> Void)
    func loveOrder(bodyDTO: LoveInfoRequestBodyDTO, completion: @escaping (NetworkResult<LoveInfoResponseDTO>) -> Void)

}

final class InfoTalkService : APIRequestLoader<InfoTalkTarget>,InfoTalkServiceProtocol {
    func viewOrder(bodyDTO: ViewInfoRequestBodyDTO, completion: @escaping (NetworkResult<ViewInfoResponseDTO>) -> Void) {
        fetchData(target: .viewInfo(bodyDTO), responseData: ViewInfoResponseDTO.self, completion: completion)
    }

    func oldestOrder(bodyDTO: OldestInfoRequestBodyDTO, completion: @escaping (NetworkResult<OldestInfoResponseDTO>) -> Void) {
        fetchData(target: .oldestInfo(bodyDTO), responseData: OldestInfoResponseDTO.self, completion: completion)
    }
    
    func loveOrder(bodyDTO: LoveInfoRequestBodyDTO, completion: @escaping (NetworkResult<LoveInfoResponseDTO>) -> Void) {
        fetchData(target: .loveInfo(bodyDTO), responseData: LoveInfoResponseDTO.self, completion: completion)
    }

    func latestInfo(bodyDTO: LatestInfoRequestBodyDTO, completion: @escaping (NetworkResult<LatestInfoResponseDTO>) -> Void) {
        fetchData(target: .latestInfo(bodyDTO), responseData: LatestInfoResponseDTO.self, completion: completion)
    }
    
    func infoTalkSave(bodyDTO: InfoTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void) {
        fetchData(target: .infoTalkSave(bodyDTO), responseData: BaseResponse<Int>.self, completion: completion)
    }
    
}
