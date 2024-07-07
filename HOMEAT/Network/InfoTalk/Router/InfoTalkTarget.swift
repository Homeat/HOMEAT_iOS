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
    case viewInfo(_ bodyDTO: ViewInfoRequestBodyDTO)
    case loveInfo(_ bodyDTO: LoveInfoRequestBodyDTO)
    case latestInfo(_ bodyDTO: LatestInfoRequestBodyDTO)
    case oldestInfo(_ bodyDTO: OldestInfoRequestBodyDTO)
    case postReport(_ bodyDTO: PostInfoRequestBodyDTO)
    case commentReport(_ bodyDTO: InfoCommentRequestBodyDTO)
    case postLove(_ bodyDTO: InfoLoveRequestBodyDTO) //공감
    case postLoveDelete(_ bodyDTO: InfoDeleteLoveRequestBodyDTO) //공감 취소
    case complainPost(_ bodyDTO: ComplainPostRequestBodyDTO) //게시물 신고
    case complainComment(_ bodyDTO: ComplainCommentRequestBodyDTO) // 댓글 신고 
    case deletePost(_ bodyDTO: InfoDeletePostRequestBodyDTO) //게시글 삭제
    case deleteComment(_ bodyDTO: InfoDeleteCommentRequestBodyDTO) // 댓글 삭제
    case replyComment(_ bodyDTO: InfoReplyRequestBodyDTO) //대댓글
}
extension InfoTalkTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .infoTalkSave:
            return .authorization
        case .viewInfo:
            return .authorization
        case .loveInfo:
            return .authorization
        case .latestInfo:
            return .authorization
        case .oldestInfo:
            return .authorization
            
        case .postReport:
            return .authorization
        case .commentReport:
            return .authorization
        case .postLove:
            return .authorization
        case .postLoveDelete:
            return .authorization
        case .complainPost:
            return .authorization
        case .complainComment:
            return .authorization
        case .deletePost:
            return .authorization
        case .deleteComment:
            return .authorization
        case .replyComment:
            return .authorization
        }
    }
    var headerType: HTTPHeaderType {
        switch self {
        case .infoTalkSave:
            return .hasToken
        case .viewInfo:
            return .hasToken
        case .loveInfo:
            return .hasToken
        case .latestInfo:
            return .hasToken
        case .oldestInfo:
            return .hasToken
        case .postReport:
            return .hasToken
        case .commentReport:
            return .hasToken
        case .postLove:
            return .hasToken
        case .postLoveDelete:
            return .hasToken
        case .complainPost:
            return .hasToken
        case .complainComment:
            return .hasToken
        case .deletePost:
            return .hasToken
        case .deleteComment:
            return .hasToken
        case .replyComment:
            return .hasToken
        }
    }
    var method: HTTPMethod {
        switch self {
        case .infoTalkSave:
            return .post
        case .latestInfo:
            return .get
        case .viewInfo:
            return .get
        case .loveInfo:
            return .get
        case .oldestInfo:
            return .get
        case .postReport:
            return .get
        case .commentReport:
            return .post
        case .postLove:
            return .post
        case .postLoveDelete:
            return .delete
        case .complainPost:
            return .post
        case .complainComment:
            return .post
        case .deletePost:
            return .delete
        case .deleteComment:
            return .delete
        case .replyComment:
            return .post
        }
    }
    var path: String {
        switch self {
        case .infoTalkSave:
            return "/v1/infoTalk"
        case .viewInfo:
            return "/v1/infoTalk/posts/view"
        case .loveInfo:
            return "/v1/infoTalk/posts/love"
        case .latestInfo:
            return "/v1/infoTalk/posts/latest"
        case .oldestInfo:
            return "/v1/infoTalk/posts/oldest"
        case .postReport(let queryDTO):
            return "/v1/infoTalk/\(queryDTO.id)"
        //댓글작성
        case .commentReport(let bodyDTO):
            return "/v1/infoTalk/comment/\(bodyDTO.id))"
        case .postLove(let bodyDTO):
            return "/v1/infoTalk/love/\(bodyDTO.id)"
        case .postLoveDelete(let bodyDTO):
            return "/v1/infoTalk/love/\(bodyDTO.id)"
        case .complainPost(let bodyDTO):
            return "/v1/infoTalk/report/\(bodyDTO.postId))"
        case .complainComment(let bodyDTO):
            return "/v1/infoTalk/report/\(bodyDTO.commentId))"
        case .deletePost(let bodyDTO):
            return "/v1/infoTalk/\(bodyDTO.id)"
        case .deleteComment(let bodyDTO):
            return "/v1/infoTalk/comment/\(bodyDTO.commentId)"
        case .replyComment(let bodyDTO):
            return "/v1/infoTalk/reply/\(bodyDTO.id)"
        }
    }
    var parameters: RequestParams {
        switch self {
        case let .infoTalkSave(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case let .latestInfo(queryDTO):
            return .requestQuery(queryDTO)
        case let .loveInfo(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .viewInfo(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .oldestInfo(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .postReport(queryDTO):
            return .requestQuery(queryDTO)
        case let .commentReport(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .postLove(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .postLoveDelete(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .complainPost(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .complainComment(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .deletePost(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .deleteComment(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .replyComment(bodyDTO):
            return .requestWithBody(bodyDTO)
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
