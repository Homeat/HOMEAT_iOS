//
//  MyPageTarget.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/7/24.
//

import Foundation
import Alamofire

enum MyPageTarget {
    case mypage //부가 회원정보 조회
    case mypageEdit(_ bodyDTO: MyPageEditRequestBodyDTO)
    case mypageProfile(_ bodyDTO: ProfileEditRequestBodyDTO)
    case mypageDetail
    case myProfileDelete
    case myPageWithDraw
    case myPageReactivate
    case myPassword(_ bodyDTO: MyPasswordRequestBodyDTO)
    case myNicknameExist(_ bodyDTO: NicknameRequestBodyDTO)
    case mypageLogout
    case incomeEdit(_ bodyDTO: IncomeReuqestBodyDTO)
    case nicknameEdit(_ bodyDTO: NicknameRequestBodyDTO)
}

extension MyPageTarget: TargetType {
    
    var authorization: Authorization {
        switch self {
        case .mypage:
            return .authorization
        case .mypageEdit:
            return .authorization
        case .mypageProfile:
            return .authorization
        case .mypageDetail:
            return .authorization
        case .myProfileDelete:
            return .authorization
        case .myPageWithDraw:
            return .authorization
        case .myPageReactivate:
            return .authorization
        case .myPassword:
            return .authorization
        case .myNicknameExist:
            return .authorization
        case .mypageLogout:
            return .reAuthorization
        case .incomeEdit:
            return .authorization
        case .nicknameEdit:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .mypage:
            return .hasToken
        case .mypageEdit:
            return .hasToken
        case .mypageProfile:
            return .hasToken
        case .mypageDetail:
            return .hasToken
        case .myProfileDelete:
            return .hasToken
        case .myPageWithDraw:
            return .hasToken
        case .myPageReactivate:
            return .hasToken
        case .myPassword:
            return .hasToken
        case .myNicknameExist:
            return .hasToken
        case .mypageLogout:
            return .refreshToken
        case .incomeEdit:
            return .hasToken
        case .nicknameEdit:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .mypage:
            return .get
        case .mypageEdit:
            return .patch
        case .mypageProfile:
            return .patch
        case .mypageDetail:
            return .get
        case .myProfileDelete:
            return .delete
            
        case .myPageWithDraw:
            return .patch
        case .myPageReactivate:
            return .patch
        case .myPassword:
            return .patch
        case .myNicknameExist:
            return .post
        case .mypageLogout:
            return .post
        case .incomeEdit:
            return .patch
        case .nicknameEdit:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .mypage:
            return "/v1/mypage/"
        case .mypageEdit:
            return "/v1/mypage"
        case .mypageProfile:
            return "/v1/mypage/profile"
        case .mypageDetail:
            return "/v1/mypage/detail"
        case .myProfileDelete:
            return "/v1/mypage/profile"
        case .myPageWithDraw:
            return "/v1/mypage/withdraw"
        case .myPageReactivate:
            return "/v1/mypage/reactivate"
        case .myPassword:
            return "/v1/mypage/change-password"
        case .myNicknameExist:
            return "/v1/mypage/exist-nickname"
        case .mypageLogout:
            return "/v1/members/logout"
        case .incomeEdit:
            return "/v1/mypage/income"
        case .nicknameEdit:
            return "/v1/mypage/nickname"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .mypage:
            return .requestPlain
        case .mypageEdit(let bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .mypageProfile(bodyDTO):
            return .requestWithMultipart(bodyDTO.toMultipartFormData())
        case .mypageDetail:
            return .requestPlain
        case .myProfileDelete:
            return .requestPlain
        case .myPageWithDraw:
            return .requestPlain
        case .myPageReactivate:
            return .requestPlain
        case let .myPassword(bodyDTO):
            return .requestWithBody(bodyDTO)
        case let .myNicknameExist(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .mypageLogout:
            return .requestPlain
        case .incomeEdit(let bodyDTO):
            return .requestWithBody(bodyDTO)
        case .nicknameEdit(let bodyDTO):
            return .requestWithBody(bodyDTO)
        }
    }
}

extension ProfileEditRequestBodyDTO {
    func toMultipartFormData() -> (MultipartFormData) -> Void {
        return { formData in
            print("multipartformdata 출력")
            if let imageData = self.profileImg {
                print("Image data is not nil. Size: \(imageData.count)")
                formData.append(imageData, withName: "profileImg", fileName: "image.jpg", mimeType: "image/jpeg")
            } else {
                print("Image data is nil or empty")
            }
        }
    }
}
