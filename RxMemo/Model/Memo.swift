//
//  Memo.swift
//  RxMemo
//
//  Created by SeoYeon Hong on 2021/05/21.
//

import Foundation

struct Memo: Equatable {
    var content: String      //메모내용
    var insertDate: Date     //생성날짜
    var identity: String     //메모구분
    
    //생성자
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"  //insertDate의 timeInterval 값을 문자열로 바꿔서 저장
    }
    //업데이트된 내용으로 새로운 instance를 생성할 때 사용되는 생성자
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
