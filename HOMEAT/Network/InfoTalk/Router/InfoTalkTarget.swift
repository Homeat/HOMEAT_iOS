//
//  InfoTalkTarget.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/22/24.
//

import Foundation
import Alamofire

enum InfoTalkTarget {
    case infoTalkSave(_ bodyDTO: InfoTalkSaveRequestBodyDTO)
}
extension InfoTalkTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .infoTalkSave:
            return .authorization
        }
    }
    var headerType: HTTPHeaderType {
        switch self {
        case .infoTalkSave:
            return .hasToken
        }
    }
    var method: HTTPMethod {
        switch self {
        case .infoTalkSave:
            return .post
        }
    }
    var path: String {
        switch self {
        case .infoTalkSave:
            return "/v1/infoTalk"
        }
    }
    var parameters: RequestParams {
        switch self {
        case let .infoTalkSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        }
    }
}

extension InfoTalkSaveRequestBodyDTO {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            formData.append(self.title.data(using: .utf8) ?? Data(), withName: "title")
            formData.append(self.content.data(using: .utf8) ?? Data(), withName: "content")
            // tags 배열을 JSON 형식의 문자열로 인코딩
            if let tagsData = try? JSONEncoder().encode(self.tags) {
                formData.append(tagsData, withName: "tags")
            }            // 사진을 formData에 추가하는 경우
            print("multipartformdata 출력")
            if let infoPhotos = self.imgUrl {
                print("Profile Photos is not empty. Count: \( infoPhotos.count)")
                for (index, image) in infoPhotos.enumerated() {
                    print("Index: \(index), Photo: \(image)")
                    formData.append(image, withName: "imgUrl", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            } else {
                print("Profile Photos is nil or empty")
            }
        }
    }
}
