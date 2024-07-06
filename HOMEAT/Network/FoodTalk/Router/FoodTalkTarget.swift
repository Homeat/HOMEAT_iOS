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
    case replyReport(_ bodyDTO: ReplyReportRequestBodyDTO)
    case postReport(_ bodyDTO: PostReportRequestBodyDTO)
    case commentReport(_ bodyDTO: CommentReportRequestBodyDTO)
    case replyWrite(_ bodyDTO: ReplyWriteRequestBodyDTO)
    case love(_ bodyDTO: LoveRequestBodyDTO)
    case deleteLove(_ bodyDTO: DeleteLoveRequestBodyDTO)
    case commentWrite(_ bodyDTO: CommentWriteRequestBodyDTO)
    case checkOne(_ bodyDTO: CheckOneRequestBodyDTO)
    case viewOrder(_ bodyDTO: ViewOrderRequestBodyDTO)
    case oldestOrder(_bodyDTO: OldestOrderRequestBodyDTO)
    case loveOrder(_ bodyDTO: LoveOrderRequestBodyDTO)
    case latestOrder(_ bodyDTO: LatestOrderRequestBodyDTO)
    case deleteReply(_ bodyDTO: DeleteReplyRequestBodyDTO)
    case deletePost(_ bodyDTO: DeletePostRequestBodyDTO)
    case deleteComment( _bodyDTO: DeleteCommentRequestBodyDTO)
}

extension FoodTalkTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .foodTalkSave:
            return .authorization
        case .replyReport:
            return .authorization
        case .postReport:
            return .authorization
        case .commentReport:
            return .authorization
        case .replyWrite:
            return .authorization
        case .love:
            return .authorization
        case .deleteLove:
            return .authorization
        case .commentWrite:
            return .authorization
        case .checkOne:
            return .authorization
        case .viewOrder:
            return .authorization
        case .oldestOrder:
            return .authorization
        case .loveOrder:
            return .authorization
        case .latestOrder:
            return .authorization
        case .deleteReply:
            return .authorization
        case .deletePost:
            return .authorization
        case .deleteComment:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .foodTalkSave:
            return .hasToken
        case .replyReport:
            return .hasToken
        case .postReport:
            return .hasToken
        case .commentReport:
            return .hasToken
        case .replyWrite:
            return .hasToken
        case .love:
            return .hasToken
        case .deleteLove:
            return .hasToken
        case .commentWrite:
            return .hasToken
        case .checkOne:
            return .hasToken
        case .viewOrder:
            return .hasToken
        case .oldestOrder:
            return .hasToken
        case .loveOrder:
            return .hasToken
        case .latestOrder:
            return .hasToken
        case .deleteReply:
            return .hasToken
        case .deletePost:
            return .hasToken
        case .deleteComment:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .foodTalkSave:
            return .post
        case .replyReport:
            return .post
        case .postReport:
            return .post
        case .commentReport:
            return .post
        case .replyWrite:
            return .post
        case .love:
            return .post
        case .deleteLove:
            return .delete
        case .commentWrite:
            return .post
        case .checkOne:
            return .get
        case .viewOrder:
            return .get
        case .oldestOrder:
            return .get
        case .latestOrder:
            return .get
        case .loveOrder:
            return .get
        case .deleteReply:
            return .delete
        case .deletePost:
            return .delete
        case .deleteComment:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .foodTalkSave:
            return "/v1/foodTalk"
        case .replyReport(let bodyDTO):
            return "/v1/foodTalk/report/reply/\(bodyDTO.replyId)"
        case .postReport(let bodyDTO):
            return "/v1/foodTalk/report/post/\(bodyDTO.postId)"
        case .commentReport(let bodyDTO):
            return "/v1/foodTalk/report/comment/\(bodyDTO.commentId)"
        case .replyWrite(let bodyDTO):
            return "/v1/foodTalk/reply/\(bodyDTO.commentId)"
        case .love(let bodyDTO):
            return "/v1/foodTalk/love/\(bodyDTO.id)"
        case .deleteLove(let bodyDTO):
            return "/v1/foodTalk/love/\(bodyDTO.id)"
        case .commentWrite(let bodyDTO):
            return "/v1/foodTalk/comment/\(bodyDTO.postId)"
        case .checkOne(let bodyDTO):
            return "/v1/foodTalk/\(bodyDTO.id)"
        case .viewOrder:
            return "/v1/foodTalk/posts/view"
        case .oldestOrder:
            return "/v1/foodTalk/posts/oldest"
        case .latestOrder:
            return "/v1/foodTalk/posts/latest"
        case .loveOrder:
            return "/v1/foodTalk/posts/love"
       case .deleteReply(let bodyDTO):
            return "/v1/foodTalk/delete/\(bodyDTO.replyId)"
        case .deletePost(let bodyDTO):
            return "/v1/foodTalk/\(bodyDTO.id)"
        case .deleteComment(let bodyDTO):
            return "/v1/foodTalk/comment/\(bodyDTO.commentId)"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .foodTalkSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .replyReport(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .postReport(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .commentReport(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .replyWrite(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .love(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .deleteLove(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .commentWrite(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .checkOne(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .viewOrder(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .oldestOrder(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .latestOrder(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .loveOrder(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .deleteReply(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .deletePost(bodyDTO):
            return .requestQuery(bodyDTO)
        case let .deleteComment(bodyDTO):
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
            if let ingredient = self.ingredient {
                formData.append(ingredient.data(using: .utf8) ?? Data(), withName: "ingredient")
            }
            print("multipartformdata 출력")
            
            // 사진을 formData에 추가하는 경우
            if let foodPhotos = self.foodPictures, !foodPhotos.isEmpty {
                print("Food Photos is not empty. Count: \(foodPhotos.count)")
                for (index, image) in foodPhotos.enumerated() {
                    print("Index: \(index), Photo Size: \(image.count) bytes")
                    formData.append(image, withName: "foodPictures", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            } else {
                print("Food Photos is nil or empty")
            }

            for (index, foodRecipeDTOS) in self.foodRecipeRequest.enumerated() {
                print("Appending recipe \(index)")
                formData.append(foodRecipeDTOS.recipe.data(using: .utf8) ?? Data(), withName: "foodRecipeDTOS[\(index)].recipe")
                if let recipePicture = foodRecipeDTOS.recipePicture {
                    print("Appending recipe picture \(index), Size: \(recipePicture.count) bytes")
                    formData.append(recipePicture, withName: "foodRecipeDTOS[\(index)].recipePicture", fileName: "recipePicture\(index).jpg", mimeType: "image/jpeg")
                }
            }
        }
    }
}



