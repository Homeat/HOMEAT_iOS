//
//  NetworkService.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation
import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    let onboardingService: OnboardingServiceProtocol = OnboardingService(apiLogger: APIEventLogger())
    let analysisService: AnalysisServiceProtocol = AnalysisService(apiLogger: APIEventLogger())
    let foodTalkService: FoodTalkServiceProtocol = FoodTalkService(apiLogger: APIEventLogger())
}
