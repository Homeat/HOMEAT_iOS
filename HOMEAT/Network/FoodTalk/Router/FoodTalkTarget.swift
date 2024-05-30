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
    case replyWrite(_ bodyDTO: ReplyWriteRequestBodyDTO)
    case recipeSave(_ bodyDTO: RecipeSaveRequestBodyDTO)
    case love(_ bodyDTO: LoveRequestBodyDTO)
    case deleteLove(_ bodyDTO: DeleteLoveRequestBodyDTO)
    case commentWrite(_ bodyDTO: CommentWriteRequestBodyDTO)
    case latestOrder(_ bodyDTO: LatestOrderRequestBodyDTO)
    case loveOrder(_ bodyDTO: LoveOrderRequestBodyDTO)
}

extension FoodTalkTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .foodTalkSave:
            return .authorization
        case .replyWrite:
            return .authorization
        case .recipeSave:
            return .authorization
        case .love:
            return .authorization
        case .deleteLove:
            return .authorization
        case .commentWrite:
            return .authorization
        case .latestOrder:
            return .authorization
        case .loveOrder:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .foodTalkSave:
            return .hasToken
        case .replyWrite:
            return .hasToken
        case .recipeSave:
            return .hasToken
        case .love:
            return .hasToken
        case .deleteLove:
            return .hasToken
        case .commentWrite:
            return .hasToken
        case .latestOrder:
            return .hasToken
        case .loveOrder:
            return .hasToken
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .foodTalkSave:
            return .post
        case .replyWrite:
            return .post
        case .recipeSave:
            return .post
        case .love:
            return .post
        case .commentWrite:
            return .post
        case .deleteLove:
            return .delete
        case .latestOrder:
            return .get
        case .loveOrder:
            return .get
        
        }
    }
    
    var path: String {
        switch self {
        case .foodTalkSave:
            return "/v1/foodTalk/save"
        case .replyWrite:
            return "/v1/foodTalk/reply"
        case .recipeSave:
            return "/v1/foodTalk/recipe"
        case .love(let bodyDTO):
            return "/v1/foodTalk/love/\(bodyDTO.id)"
        case .deleteLove(let bodyDTO):
            return "/v1/foodTalk/love/\(bodyDTO.id)"
        case .commentWrite:
            return "/v1/foodTalk/comment"
        case .latestOrder:
            return "/v1/foodTalk/posts/latest"
        case .loveOrder:
            return "/v1/foodTalk/posts/love"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .foodTalkSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .replyWrite(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .recipeSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .love(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .deleteLove(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .commentWrite(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .latestOrder(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .loveOrder(bodyDTO):
            return .requestWithBody(bodyDTO)
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

