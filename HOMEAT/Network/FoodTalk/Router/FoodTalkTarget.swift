//
//  FoodTalkTarget.swift
//  HOMEAT
//
//  Created by 이지우 on 5/25/24.
//

import Foundation
import Alamofire

enum FoodTalkTarget {
    //url별로 case 나눔
    case foodTalkSave(_ bodyDTO: FoodTalkSaveRequestBodyDTO)
    case recipeSave(_ bodyDTO: RecipeSaveRequestBodyDTO)
    case commentWrite(_ bodyDTO: CommentWriteRequestBodyDTO)
    case replyWrite(_ bodyDTO: ReplyWriteRequestBodyDTO)
    case love(_ bodyDTO: LoveRequestBodyDTO)
    case latest(_ bodyDTO: LatestRequestBodyDTO)
}

extension FoodTalkTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .foodTalkSave:
            return .authorization
        case .recipeSave:
            return .authorization
        case .commentWrite:
            return .authorization
        case .replyWrite:
            return .authorization
        case .love:
            return .authorization
        case .latest:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .foodTalkSave:
            return .hasToken
        case .recipeSave:
            return .hasToken
        case .commentWrite:
            return .hasToken
        case .replyWrite:
            return .hasToken
        case .love:
            return .hasToken
        case .latest:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .foodTalkSave:
            return .post
        case .recipeSave:
            return .post
        case .commentWrite:
            return .post
        case .replyWrite:
            return .post
        case .love:
            return .post
        case .latest:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .foodTalkSave:
            return "/v1/foodTalk/save"
        case .recipeSave:
            return "/v1/foodTalk/recipe"
        case .commentWrite:
            return "/v1/foodTalk/comment"
        case .replyWrite:
            return "/v1/foodTalk/reply"
        case .love(let bodyDTO):
            return "/v1/foodTalk/love/\(bodyDTO.id)"
        case .latest:
            return "/v1/foodTalk/posts/latest"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .foodTalkSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .recipeSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .commentWrite(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .replyWrite(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .love(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .latest(bodyDTO):
            return .requestQuery(bodyDTO)
        }
    }
}

extension FoodTalkSaveRequestBodyDTO {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            formData.append(self.name.data(using: .utf8) ?? Data(), withName: "name")
            formData.append(self.memo.data(using: .utf8) ?? Data(), withName: "memo")
            formData.append(self.tag.data(using: .utf8) ?? Data(), withName: "tag")
            // 사진을 formData에 추가하는 경우
            print("multipartformdata 출력")
            if let foodPhotos = self.image {
                print("Profile Photos is not empty. Count: \(foodPhotos.count)")
                for (index, image) in foodPhotos.enumerated() {
                    print("Index: \(index), Photo: \(image)")
                    formData.append(image, withName: "foodPhotos", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            } else {
                print("Profile Photos is nil or empty")
            }
        }
    }
}

extension RecipeSaveRequestBodyDTO {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            formData.append("\(self.id)".data(using: .utf8) ?? Data(), withName: "id")
            formData.append(self.recipe.data(using: .utf8) ?? Data(), withName: "memo")
            formData.append(self.ingredient.data(using: .utf8) ?? Data(), withName: "ingredient")
            formData.append(self.tip.data(using: .utf8) ?? Data(), withName: "tip")
            // 사진을 formData에 추가하는 경우
            print("multipartformdata 출력")
            if let foodPhotos = self.files {
                print("Profile Photos is not empty. Count: \(foodPhotos.count)")
                for (index, image) in foodPhotos.enumerated() {
                    print("Index: \(index), Photo: \(image)")
                    formData.append(image, withName: "foodPhotos", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            } else {
                print("Profile Photos is nil or empty")
            }
        }
    }
}

