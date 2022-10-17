//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
