//
//  HomeTarget.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/24/24.
//

import Foundation
import Alamofire


enum HomeSceneTarget {
    case homeInfo
    case ocr(_ bodyDTO: OcrRequestBodyDTO)
    case payAdd(_ bodyDTO: PayAddRequestBodyDTO)
}

extension HomeSceneTarget: TargetType {

    var authorization: Authorization {
        switch self {
        case .homeInfo:
            return .authorization
        case .ocr:
            return .authorization
        case .payAdd:
            return .authorization
        }
    }

    var headerType: HTTPHeaderType {
        switch self {
        case .homeInfo:
            return .hasToken
        case .ocr:
            return .hasToken
        case .payAdd:
            return .hasToken
        }
    }

    var method: HTTPMethod {
        switch self {
        case .homeInfo:
            return .get
        case .ocr:
            return .post
        case .payAdd:
            return .post
        }

    }

    var path: String {
        switch self {
        case .homeInfo:
            return "/v1/home/"
        case .ocr:
            return "/v1/home/receipt"
        case .payAdd:
            return "/v1/home/add-expense"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .homeInfo:
            return .requestPlain
        case .ocr(let bodyDTO):
            return .requestWithBody(bodyDTO)
        case .payAdd(let bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        }
    }
}

extension PayAddRequestBodyDTO {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            // 사진을 formData에 추가하는 경우
            print("multipartformdata 출력")
            if let Photos = self.url {
                print("Profile Photos is not empty. Count: \(Photos.count)")
                for (index, image) in Photos.enumerated() {
                    print("Index: \(index), Photo: \(image)")
                    formData.append(image, withName: "Photos", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            } else {
                print("Profile Photos is nil or empty")
            }
        }
    }
}
