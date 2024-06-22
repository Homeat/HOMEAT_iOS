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
}

final class InfoTalkService : APIRequestLoader<InfoTalkTarget>,InfoTalkServiceProtocol {
    func infoTalkSave(bodyDTO: InfoTalkSaveRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<Int>>) -> Void) {
        fetchData(target: .infoTalkSave(bodyDTO), responseData: BaseResponse<Int>.self, completion: completion)
    }
    
}
