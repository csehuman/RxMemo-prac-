//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import RxDataSources

typealias MemoSectionModel = AnimatableSectionModel<Int, Memo>
typealias MemoSectionDataSource = RxTableViewSectionedAnimatedDataSource<MemoSectionModel>

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[MemoSectionModel]> {
        return storage.memoList()
    }
    
    let dataSource: MemoSectionDataSource = {
        let ds = MemoSectionDataSource(
            configureCell: { dataSource, tableView, indexPath, memo -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = memo.content
                return cell
            })
        
        ds.canEditRowAtIndexPath = { _, _ in return true }
        
        return ds
    }()
    
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "새 메모", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true)
                        .asObservable()
                        .map { _ in }
                }
        }
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }
    
    lazy var detailAction: Action<Memo, Void> = { // class 내부에서 self에 접근해야되기 때문에 lazy로 선언.
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true)
                .asObservable()
                .map { _ in }
        }
    }()
    
    lazy var deleteAction: Action<Memo, Void> = {
        return Action { memo in
            return self.storage.delete(memo: memo)
                .map { _ in }
        }
    }()
}
