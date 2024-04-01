//
//  StringLiteral.swift
//  HOMEAT
//
//  Created by 강석호 on 3/30/24.
//

import Foundation

enum StringLiterals {
    
    // 필요한 enum을 만들어서 사용해주세요
    // 사용예시: titleLabel.text = StringLiterals.TabBar.home
    
    enum Update {
        static let title = "업데이트 알림"
        static let description = "유저분들의 의견을 반영하여 사용성을 개선했습니다. 앱을 사용하기 위해서는 새로운 버전으로 업데이트 후 이용해 주세요."
        static let button = "업데이트하기"
    }
    
    enum Onboarding {
        enum ButtonTitle {
            static let appleLogin = "Apple로 시작하기"
            static let existingOrganization = "이미 등록된\n단체가 있어요"
            static let makeOrganization = "새로운 단체를\n등록하고 싶어요"
            static let requestOrganization = "단체를 직접 추가해주세요"
            static let skipButtonTitle = "건너뛰기"
            static let duplicationCheck = "중복 확인"
            static let startHome = "홈으로 시작하기"
        }
        
    }
    
    enum TabBar {
        enum ItemTitle {
            static let home = "홈"
            static let recommend = "랭킹"
            static let addPingle = "개최"
            static let setting = "더보기"
        }
    }
    
    enum Fix {
        static let fixTitle = "아직 공사중!"
        static let fixDescription = "아직 구현중인 기능이에요\n조금만 기다려주세요"
    }
    
    enum Recommend {
        static let rankingTitle = "랭킹"
        static let nonRanking = "우리 단체에서 랭킹을 확인할 수 있어요!"
        static let latestVisit = "최근방문"
    }
    
    enum Home {
        enum Detail {
            static let participantsTitle = "참여현황"
            static let slash = "/"
            static let complete = "모집완료"
            static let dateTimeTitle = "일시"
            static let locationTitle = "장소"
            static let talkButton = "대화하기"
            static let participationButton = "참여하기"
            static let backButton = "돌아가기"
        }
        
        enum Participants {
            static let participationTitle = "참여현황"
            static let meetingOwner = "개최자"
        }
        
        enum List {
            static let sortRecent = "최신등록순"
            static let sortImminent = "날짜임박순"
        }
        
        enum Search {
            static let searchMapPlaceHolder = "장소 이름 검색"
            static let searchEmptyLabel = "검색 결과가 없어요"
        }
    }
    
    enum Meeting {
        enum MeetingCategory {
            enum CategoryTitle {
                static let play = "PLAY"
                static let study = "STUDY"
                static let multi = "MULTI"
                static let others = "OTHERS"
            }
            
            enum ExplainCategory {
                static let playExplain = "노는게 제일 좋아!"
                static let studyExplain = "열공, 열작업할 사람 모여라!"
                static let multiExplain = "놀 땐 놀고, 일할 땐 일하자!"
                static let othersExplain = "다른 활동이 하고싶다면?"
            }
            
            enum ExitButton {
                static let exitButton = "나가기"
                static let exitLabel = "나중에 만드시겠어요?"
            }
        }
        
        enum DatePicker {
            enum PickerButton {
                static let doneButton = "Done"
                static let resetButton = "Reset"
            }
        }
        
        enum DateSelection {
            static let dateSelecionTitle = "함께할 친구들과\n언제 만날까요?"
            static let warningMessage = "종료 시각은 시작 시각 이후로 선택해주세요!"
        }
        
        enum ExitModalView {
            static let exitQuestion = "잠깐! 나가실건가요?"
            static let exitWarning = "지금까지 입력한 정보는 전부 사라져요"
            static let continueMaking = "이어서 작성하기"
        }
        
        enum Recruitment {
            static let recruitTitle = "몇 명의 친구들과\n만날까요?"
            static let recruitCondition = "본인을 포함하여,\n최소 1명부터 참여 인원을 선택해주세요"
        }
        
        enum FinalResult {
            enum FinalResultCard {
                static let finalCardCalendar = "일시"
                static let fincalCardPlace = "장소"
                static let finalCardRecruitNumber = "모집인원"
            }
        }
    }
    
    enum Profile {
        enum ExplainTitle {
            static let settingTitle = "더보기"
            static let organizationTitle = "나의 단체"
            static let versionTitle = "버전"
            static let logoutQuestionTitle = "정말로 로그아웃 하실건가요?"
        }
    }
    
    enum ErrorMessage {
        static let notFoundMeeting = "존재하지 않는 번개입니다"
        static let notFoundMember = "존재하지 않는 유저미팅입니다."
    }
}
