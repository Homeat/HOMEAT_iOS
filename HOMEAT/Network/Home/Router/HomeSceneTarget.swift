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
    case payEdit(_ bodyDTO: PayEditRequestBodyDTO)
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
        case .payEdit:
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
        case .payEdit:
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
        case .payEdit:
            return .patch
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
        case .payEdit:
            return "/v1/home/next-target-expense"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .homeInfo:
            return .requestPlain
        case let .ocr(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case .payAdd(let bodyDTO):
            return .requestWithBody(bodyDTO)
        case .payEdit(let bodyDTO):
            return .requestWithBody(bodyDTO)
        }
    }
}

extension OcrRequestBodyDTO {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            print("multipartformdata 출력")
            if let imageData = self.file {
                print("Image data is not nil. Size: \(imageData.count)")
                formData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            } else {
                print("Image data is nil or empty")
            }
        }
    }
}

