//
//  TargetType.swift
//  HOMEAT
//
//  Created by 강석호 on 4/11/24.
//

import Foundation

import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var headerType: HTTPHeaderType { get }
    var authorization: Authorization { get }
}

extension TargetType {
    var baseURL: String {
        return "https://dev.homeat.site"
    }
    var headers: [String: String]? {
        switch headerType {
        case .plain:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue
            ]
        case .hasToken:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderField.authentication.rawValue: "Bearer \(KeychainHandler.shared.accessToken)"
            ]
        case .refreshToken:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderField.authentication.rawValue: "Bearer \(KeychainHandler.shared.refreshToken)"
            ]
            
        case .providerToken:
            return [
                HTTPHeaderField.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderField.providerToken.rawValue: KeychainHandler.shared.providerToken
            ]
        }
    }
}
extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        let accessToken = KeychainHandler.shared.accessToken
        var urlRequest = try URLRequest(
            url: url.appendingPathComponent(path),
            method: method
        )
        
        switch authorization {
        case .authorization:
            urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        case .unauthorization:
            break
        case .socialAuthorization:
            urlRequest.setValue(KeychainHandler.shared.providerToken, forHTTPHeaderField: HTTPHeaderField.providerToken.rawValue)
        case .reAuthorization:
            urlRequest.setValue(KeychainHandler.shared.refreshToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        case .emailAuthorization:
            urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        switch headerType {
        case .plain:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        case .hasToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        case.refreshToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.setValue("Bearer \(KeychainHandler.shared.refreshToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        case .providerToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.setValue(KeychainHandler.shared.providerToken, forHTTPHeaderField: HTTPHeaderField.providerToken.rawValue)
        }
        
        switch parameters {
        case .requestWithBody(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        case .requestQuery(let request):
            let params = request?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .requestQueryWithBody(let queryRequest, let bodyRequest):
            let params = queryRequest?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            
            let bodyParams = bodyRequest?.toDictionary() ?? [:]
            
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
            
        case .requestPlain:
            break
        }
        return urlRequest
    }
}

@frozen
enum RequestParams {
    case requestPlain
    case requestWithBody(_ paramter: Encodable?)
    case requestQuery(_ parameter: Encodable?)
    case requestQueryWithBody(_ queryParameter: Encodable?, bodyParameter: Encodable?)
    case requestWithMultipart(_ multipartFormData: (MultipartFormData) -> Void)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any]
        else { return [:] }
        
        return dictionaryData
    }
}
