//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by SeoYeon Hong on 2021/05/21.
//

import Foundation
import RxSwift

protocol MemoStorageType {      //기본적인 CRUD 선언
    @discardableResult      //작업결과가 필요없는 경우를 위해 @discardableResult 특성 추가
    func createMemo(content: String) -> Observable<Memo>    //작업결과로 observable을 리턴
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
