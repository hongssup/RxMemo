//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by SeoYeon Hong on 2021/05/21.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {      //메모리에 메모를 저장하는 클래스
    //클래스 외부에서 배열에 직접 접근할 필요 없기에 private으로 선언. 배열은 observable을 통해 외부로 공개되고  배열 상태가 업데이트되면 새로운 next event 방출.
    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    //기본값을 list 배열로 선언하기 위해 lazy로 선언.
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    //새로운 메모 생성하고 배열에 추가
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)      //subject에서 새로운 next event 방출
        
        return Observable.just(memo)    //새로운 메모 방출하는 observable 리턴
    }
    //클래스 외부에서는 항상 이 메서드를 통해 subject에 접근
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    //업데이트된 메모 instance 생성 후 배열에 저장된 원본 instance 새로운 instance로 교체
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    //list 배열에서 메모 삭제 후 subject에서 새로운 next event 방출
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    
}
