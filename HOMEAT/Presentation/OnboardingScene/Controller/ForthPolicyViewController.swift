//
//  ForthPolicyViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 7/11/24.
//

import Foundation
import UIKit

class ForthPolicyViewController : BaseViewController {
    let text =
"""
홈잇은 개인정보 보호법 제 22조 제4항과 제39조의 3에 따라 사용자의 광고성 정보 수신과 이에 따른 개인정보 처리에 대한 동의를 받고 있습니다. 약관에 동의하지 않으셔도 홈잇의 모든 서비스를 이용하실 수 있습니다. 다만, 이벤트, 혜택 등의 제한이 있을 수 있습니다.

1) 개인정보 수집 항목
- 이메일, 생년월일, 성별, 거주지

2) 개인정보 수집 이용 목적
- 이벤트 운영 및 광고성 정보 전송
- 서비스 관련 정보 전송

3) 보유 및 이용 기간
- 동의 철회 시 또는 회원 탈퇴 시까지

4) 동의 철회 방법
- 개인정보관리 페이지에서 변경 혹은 이메일으로 문의

5) 전송 방법
- 이메일

6) 전송 내용
- 혜택 정보, 이벤트 정보, 상품 정보, 신규 서비스 안내 등의 광고성 정보 제공

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
