//
//  SecondPolicyViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 7/11/24.
//

import Foundation
import UIKit

class SecondPolicyViewController : BaseViewController {
    
    let text =
"""
홈잇 개인정보처리방침
Homeat (이하 “홈잇”이라고 합니다)은 개인정보보호법, 정보통신망 이용촉진 및 정보보호에 관한 법률, 통신비밀보호법 등 정보통신서비스제공자가 준수하여야 할 관련 법령상의 규정을 준수하며, 관련 법령에 의거한 개인정보 처리방침을 정하여 이용자의 권익 보호에 최선을 다하고 있습니다. 본 개인정보 처리방침은 회사가 제공하는 서비스 이용에 적용되고 다음과 같은 내용을 담고 있습니다.

01 개인정보 수집 및 이용 현황
홈잇은 원활한 서비스 제공을 위해 다음과 같은 이용자의 개인정보를 처리하고 있습니다.

•수집 및 이용 현황

1) 서비스
회원가입
2) 수집 및 이용목적
서비스 이용을 위한 이용자 식별, 이용자 개별적 통지 및 고지
3) 구분
필수
4) 수집 및 이용 항목
이메일, 위치정보, 닉네임, 생년월일, 성별, 계좌번호, 수입, 비밀번호
5) 보유 및 이용기간
회원 탈퇴시까지 ※ 단, 관계 법령 위반에 따른 수사, 조사 등이 진행중인 경우에는 해당 수사, 조사 종료 시 까지 보관 하며 내부규정 혹은 관련법령에 따라 일정 기간 보관됨

1) 서비스
본인인증
2) 수집 및 이용목적
앱 내 본인인증 서비스 제공
3) 구분
필수
4) 수집 및 이용 항목
이메일, 생년월일
5) 보유 및 이용기간
회원탈퇴시 혹은 동의 철회시 까지 ※ 단, 관계 법령 위반에 따른 수사, 조사 등이 진행중인 경우에는 해당 수사, 조사 종료 시까지 보관하며 내부규정 혹은 관련법령에 따라 일정기간 보관됨.

1) 서비스
서비스 이용 시 생성되어 수집되는 정보
2) 수집 및 이용목적
이상행위 탐지, 부정이용 방지 및 서비스 개선을 위한 분석, 이용자의 관심, 성향에 기반한개인 맞춤형 상품추천서비스(광고포함)를 제공
3) 구분
필수
4) 수집 및 이용항목
검색이력/거래기록/방문기록 등 서비스이용기록, IP주소, 단말기 정보(OS, 화면사이즈, 기기식별값,광고ID)
5) 보유 및 이용기간
회원탈퇴시 혹은 동의 철회시 까지 ※ 단, 관계 법령 위반에 따른 수사, 조사 등이 진행중인 경우에는 해당 수사, 조사 종료 시까지 보관하며 내부규정 혹은 관련법령에 따라 일정기간 보관됨.

1) 서비스
내 동네 기반 서비스
2) 수집 및 이용목적
위치정보를 지도서비스에 표시하여 서비스 이용의 편의성 증진(중고거래 희망장소표시, 동네가게 거리 정보확인 등 기타 위치정보 기반 서비스 제공) 위치정보의 통계적 분석을 통한 검색, 내동네 콘텐츠 추천 및 표시 등 각종 응용서비스 제공 고도화
3) 구분
필수
4) 수집 및 이용항목
위치정보
5) 보유 및 이용기간
회원탈퇴시 혹은 동의 철회시 까지 ※ 단, 관계 법령 위반에 따른 수사, 조사 등이 진행중인 경우에는 해당 수사, 조사 종료 시까지 보관하며 내부규정 혹은 관련법령에 따라 일정기간 보관됨.


홈잇에서 수집 및 이용되는 개인정보는 다음과 같은 경로로 수집 되고 있습니다.
• 개인정보 수집 방법
◦ 회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의하고 직접 정보를 입력하는 경우
◦ 제휴 서비스 및 단체로부터 개인정보를 제공받은 경우
◦ 고객센터를 통한 상담과정에서 앱, 메일, 전화, 팩스 등을 통해 개인정보를 수집하는 경우
◦ 서비스 이용과정에서 이용자로부터 수집하는 경우
홈잇은 원칙적으로 정해진 보유 및 이용기간에 따라 개인정보를 처리하고 있으나, 다음의 정보에 대해서는 아래의 보존 사유에 의해 명시한 기간 동안 보존합니다.
• 회사 내부 방침에 의한 사유
1) 보존 항목
부정이용기록이있는 사용자의 휴대전화번호, DI, 계좌정보(금융기관명, 계좌번호, 명의자), 기기식별값, 부정이용기록
2) 보존 사유
동일인 식별 및 부정이용방지
3) 보유기간
5년

1) 보존 항목
휴대전화번호, 기기식별값, 거래기록(판매 게시물 및 댓글내용), DI
2) 보존 사유
동일인 식별 및 중복가입방지, 휴대전화 번호 변경에 따른 탈퇴처리로인한 계정복구요청
3) 보유 기간
6개월

1) 보존 항목
휴대전화번호, 기기식별값
2) 보존 사유
거래 관련 분쟁 해결
3) 보유 기간
3개월

1) 보존 항목
거래기록 (판매 게시물 및 댓글 내용)
2) 보존 사유
거래 관련 사기 방지 및 분쟁 해결
3) 보유 기간 5년

•관련법령에 의한 사유
1) 보존 항목
계약 또는 청약철회 등에 관한 기록
2) 근거 법령
전자상거래 등에서의 소비자보호에 관한 법률
3) 보유 기간
5년

1) 보존 항목
대금결제 및 재화 등의 공급에 관한 기록
2) 근거 법령
전자상거래 등에서의 소비자보호에 관한 법률
3) 보유 기간
5년

1) 보존 항목
소비자의 불만 또는 분쟁처리 기록
2) 근거 법령
전자상거래 등에서의 소비자보호에 관한 법률
3) 보유 기간
3년

1) 보존 항목
표시/광고에 관한 기록
2) 근거 법령
전자상거래 등에서의 소비자보호에 관한 법률
3) 보유 기간
6개월

1) 보존 항목
세법이 규정하는 모든 거래에 관한 장부 및 증빙서류
2) 근거 법령
국세기본법
3) 보유 기간
5년
1) 보존 항목
전자 금융 거래에 관한 기록
2) 근거법령
전자금융거래법
3) 보유기간
5년

1) 보존 항목
서비스 방문 기록
2) 근거법령
통신비밀보호법
3) 보유기간
3개월

02 만 14세 미만 아동의 개인정보 처리
홈잇은 법정대리인의 동의가 필요한 만14세 미만 아동에 대한 정보를 수집 및 이용하지 않습니다.

03 개인정보 처리업무의 위탁에 관한 사항
홈잇은 서비스의 원활한 제공을 위해 필요한 때에는 개인정보의 처리를 일부 위탁하고 있으며, 수탁 받은 업체가 관계 법령을 준수하도록 관리·감독하고 있습니다.

04 개인정보 파기 절차 및 방법
이용자의 개인정보는 수집 및 이용목적이 달성되면 지체없이 파기합니다.(여기서 ‘이용목적이 달성된 때’란 철회요청, 서비스계약 만료, 탈퇴 시를 의미.) 다만, 회사 내부 방침 또는 관계 법령에서 정한 보관기간이 있을 경우 일정 기간동안 보관 후 파기 됩니다.
종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기하고, 전자적 파일 형태로 저장된 기록은 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.
회사는 이용고객의 민원처리 등을 위해 위치정보 수집/이용/제공 사실 확인자료를 자동 기록·보존 하며, 해당 자료는 6개월간 보관 후 파기합니다.

05 정보주체와 법정대리인의 권리 의무 및 행사 방법
이용자는 언제든지 개인정보를 조회하거나 수정할 수 있고 수집/이용에 대한 동의 철회 또는 가입 해지를 요청 할 수 있습니다.
서비스 내 설정 기능을 통한 변경, 가입해지(동의철회)를 위해서 아래의 경로를 따를 수 있습니다.
• 개인정보 조회 : 마이페이지
• 개인정보 변경 :  마이페이지 > 회원정보 수정
• 동의철회 : 마이페이지 > 탈퇴하기
혹은 운영자에게 이메일으로 문의주시면 지체없이 조치 해 드리도록 하겠습니다.

• 개인정보 관련 고객상담 접수 연락처
• 이메일 : yejin09071@gmail.com
• 개인정보 열람 및 처리정지 요구는 「개인정보보호법」 제 35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있으며, 개인정보의 정정 및 삭제 요구 시 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 삭제 해 드릴 수 없습니다.
홈잇은 정보주체 권리에 따른 열람의 요구 정정 삭제의 요구 처리정지의 요구 시 요구를 한 이용자가 본인이거나 대리인인지 확인합니다.
또한, 홈잇은 아래의 경우에 해당하는자(이하 “8세 이하의 아동 등”)의 위치정보의 보호 및 이용 등에 관한 법률 제26조 제2항의 규정에 해당하는자(이하 “보호의무자”)가 8세 이하의 아동 등의 생명 또는 신체보호를 위하여 개인위치정보의 수집, 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.
1. 8세 이하의 아동
2. 피성년후견인
3. 장애인복지법 제2조 제2항 제2호의 규정에 따른 정신적 장애를 가진자로서 장애인고용촉진 및 직업재활법 제2조 제2호의 규정에 따라 중증장애인에 해당하는자(장애인복지법 제32조의 규정에 따라 장애인등록을 한 자에한합니다.)
8세이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 수집, 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무장임을 증명하는 서면을 첨부하여 회사에 제출하여야 합니다.
보호의무자는 8세 이하의 아동 등의 개인위치정보 수집, 이용 또는 제공에 동의하는 경우 개인위치정보주체 권리의 전부를 행사할 수 있습니다.

06 개인정보의 안전성 확보조치에 관한 사항
홈잇은 「개인정보보호법」 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적, 관리적, 물리적 보호대책을 수립하여 운영하고 있습니다.
• 개인정보 취급자의 최소화 및 교육
◦ 개인정보를 처리하는 직원을 최소화 하며, 개인정보를 처리하는 모든 임직원들을 대상으로 개인정보보호 의무와 보안에 대한 정기적인 교육과 캠페인을 실시

• 개인정보에 대한 접근 제한
◦ 개인정보를 처리하는 시스템에 대한 접근권한의 부여, 변경, 말소 절차 수립 및 운영
◦ 침입탐지시스템을 이용하여 외부로부터의 무단 접근 통제

• 접속기록의 보관 및 위변조 방지
◦ 개인정보처리시스템에 접속한 기록(웹 로그, 요약정보 등)을 최소 2년 이상 보관 및 관리
◦ 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능 사용

• 개인정보의 암호화
◦신용카드 번호 등 중요정보는 암호화 되어 저장 및 관리
◦중요한 데이터는 저장 및 전송 시 암호화하여 사용하는 등의 별도 보안기능을 사용

•해킹 등에 대비한 기술적 대책
◦해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검
◦외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단
◦네트워크 트래픽의 통제(Monitoring)는 물론 불법적으로 정보를 변경하는 등의 시도를 탐지

07 개인정보를 자동으로 수집하는 장치의 설치 운영 및 거부
홈잇은 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.
쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 브라우저에게 보내는 소량의 정보이며 이용자들의 PC컴퓨터 내의 하드디스크에 저장되기도 합니다.
쿠키는 이용자들이 방문한 당의 각 서비스와 웹 사이트 들의 대한 방문 및 이용형태, 인기검색어, 보안접속 여부, 이용자 규모 등을 파악하여 이용자에게 광고를 포함한 최적화된 맞춤형 정보를 제공하기 위해 사용합니다.
이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 이용자는 웹 브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다. 다만, 쿠키의 저장을 거부할 경우에는 로그인이 필요한 일부 서비스는 이용이 어려움이 있을 수 있습니다.
쿠키 설치 허용 여부를 지정하는 방법
• Internet Explorer
◦ 웹 브라우저 상단의 톱니바퀴 아이콘 선택 > [인터넷 옵션] 선택 > [개인정보 탭] 선택 > [설정] 에서 [고급] 선택 > [쿠키] 섹션에서 설정

• Microsoft Edge
◦ 웹 브라우저 상단의 점 아이콘 선택 > [설정] 선택 > [쿠키 및 사이트 권한] 선택 > [쿠키 및 사이트 데이트 관리 및 삭제] 선택하여 설정

• Chrome
◦ 웹 브라우저 우측 상단의 점 아이콘 선택 > [설정] 선택 > [보안 및 개인정보 보호] 선택> [쿠키 및 기타 사이트 데이터 > [일반설정] 섹션에서 설정

• Whale
◦ 웹 브라우저 상단의 점 아이콘 선택 > [설정] 선택 > [개인정보 보호] 선택 > [쿠키 및 기타 사이트 데이터] 선택 > [일반설정] 섹션에서 설정

08 행태정보 수집 이용 제공 및 거부 등에 관한 사항
홈잇은 서비스 이용과정에서 정보주체에게 최적화된 맞춤형 서비스 및 혜택 온라인 맞춤형 광고 등을 제공하기 위하여 다음과 같은 행태정보를 수집합니다.

1) 수집하는 행태정보의 항목
검색이력/거래기록/방문기록 등 서비스이용기록, IP주소
2) 수집 방법
모바일 앱 이용시 자동 수집
3) 수집 목적
이용자의 관심, 성향에 기반한개인 맞춤형 상품추천서비스(광고포함)를 제공
4) 보유 이용기간 및 정보 처리 방법
회원탈퇴시 까지   ※ 단, 관계 법령 위반에 따른 수사, 조사 등이 진행중인 경우에는 해당 수사, 조사 종료 시 까지 보관 하며 내부규정혹은 관련법령에 따라 일정기간 보관됨

홈잇은 온라인 맞춤형 광고 등에 필요한 최소한의 행태정보만을 수집하며, 사상, 신념, 가족 및 친인척관계, 학력 병력, 기타 사회활동 경력 등 개인의 권리 이익이나 사생활을 뚜렷하게 침해할 우려가 있는 민감한 행태정보를 수집하지 않습니다.
홈잇은 모바일 앱에서 온라인 맞춤형 광고를 위하여 광고식별자를 수집/이용 합니다. 정보주체는 아래와 같이 모바일 단말기의 설정 변경을 통해 앱의 맞춤형 광고를 차단허용 할 수 있습니다.

• 안드로이드 단말기
◦ 설정 > 개인정보보호 > 광고 ID재설정 또는 광고ID 삭제
• 아이폰 단말기
◦ 설정 > 개인정보보호 > 추적 > 앱이 추적을 요청하도록 허용 끔

09 개인(위치)정보 보호책임자에 관한 사항
사용자가 서비스를 이용하면서 발생하는 모든 개인정보보호 관련 문의, 불만, 조언이나 기타 사항은 개인(위치)정보 보호책임자 및 담당부서로 연락해 주시기 바랍니다. 홈잇은 사용자 목소리에 귀 기울이고 신속하고 충분한 답변을 드릴 수 있도록 최선을 다하겠습니다
• 이름 : 우예진
• 직위 : 개인정보보호책임자(위치정보관리책임자)
•연락처 : yejin09071@gmail.com

10 정보주체의 권익침해에 대한 구제방법
이용자는 아래의 기관에 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다
• 개인정보 침해신고센터 (한국인터넷진흥원 운영)
◦ 소관업무 : 개인정보 침해사실 신고, 상담 신청
◦ 홈페이지 : privacy.kisa.or.kr
◦ 전화 : (국번없이) 118
◦ 주소 : 전라남도 나주시 진흥길 9 한국인터넷진흥원

• 개인정보 분쟁조정위원회
◦ 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)
◦ 홈페이지 : www.kopico.go.kr
◦ 전화 : 1833-6972
◦ 주소 : 서울특별시 종로구 세종대로 209 정부서울청사 12층
• 대검찰청 사이버수사과:
◦ (국번없이) 1301, privacy@spo.go.kr (www.spo.go.kr)
• 경찰청 사이버수사국
◦ (국번없이) 182 (사이버범죄 신고시스템 (ECRM))
홈잇은 정보주체의 개인정보자기결정권을 보장하고, 개인정보침해로 인한 상담 및 피해구제를 위해 노력하고 있으며, 신고나 상담이 필요한 경우 개인정보관련 고객상담 접수 부서 (08 정보주체와 법정대리인의 권리 의무 및 행사 방법 참고) 로 연락 해 주시기 바랍니다.
『개인정보보호법』 제25조(개인정보의 열람), 제26조(개인정보의 정정 삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에따라 행정심판을 청구할 수 있습니다.

11 개인정보처리방침의 시행 및 변경에 관한 사항
이 개인정보 처리방침은 2024년 2월 20일부터 시행되며 홈잇은 법률이나 서비스의 변경사항을 반영하기 위한 목적 등으로 개인정보처리방침이 변경되는 경우 최소 7일 전부터 공지사항을 통해 변경 사항을 고지 해드리도록 하겠습니다.
이전 개인정보처리방침은 아래에서 확인 하실 수 있습니다.



"""
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainLabel = UILabel()
    private let checkButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setConfigure() {
        
        mainLabel.do {
            $0.contentMode = .scaleAspectFit
            $0.text = text
            $0.textColor = .white
            $0.font = .bodyMedium15
            $0.numberOfLines = 0
        }
        
        checkButton.do {
            $0.backgroundColor = UIColor(named: "turquoiseGreen")
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(mainLabel, checkButton)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)  // 여기서 contentView의 너비를 scrollView의 너비와 동일하게 설정합니다.
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(10)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.top.equalTo(contentView).offset(10)
        }
        
        checkButton.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(10)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.top.equalTo(mainLabel.snp.bottom).offset(40)
            $0.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    @objc func checkButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
