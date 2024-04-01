//
//  UIColor+.swift
//  HOMEAT
//
//  Created by 강석호 on 3/30/24.
//

import Foundation
import UIKit

// UIColor 클래스를 확장시킴.
extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: Int){
        // convenience init으로 UIColor 클래스 초기화.
        // 각각의 CGFloat색을 255로 나눠서 0~1의 범위로 맞춰춤.
        self.init(red: CGFloat(r )/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
    
    // alpha가 없는 버전
    convenience init(r: Int, g: Int, b:Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha:1)
    }
    
    //rgb의 값이 모두 같을 때
    convenience init(w: Int) {
        self.init(white: CGFloat(w)/255, alpha: 1)
    }
    
}
