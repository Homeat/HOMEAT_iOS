//
//  TagItem.swift
//  HOMEAT
//
//  Created by 김민솔 on 6/21/24.
//

import Foundation

struct TagItem {
    let tagTitle: String
    // '#'를 포함시키기 위한 이니셜라이저 수정
    init(tagTitle: String) {
        if !tagTitle.hasPrefix("#") {
            self.tagTitle = "#" + tagTitle
        } else {
            self.tagTitle = tagTitle
        }
    }
}
let defaultTags: [TagItem] = [
    TagItem(tagTitle: "할인"),
    TagItem(tagTitle: "마트"),
    TagItem(tagTitle: "과일"),
    TagItem(tagTitle: "음료"),
    TagItem(tagTitle: "고기"),
    TagItem(tagTitle: "튀김"),
    TagItem(tagTitle: "야식"),
    TagItem(tagTitle: "공구"),
    TagItem(tagTitle: "재료"),
    TagItem(tagTitle: "아이스크림"),
    
]
