//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var viewModel: MemoListViewModel!
    
    func bindViewModel() {
        viewModel.title.drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected)
            .withUnretained(self) // self에 대한 비소유 참조와 zip 연산자가 방출하는 요소가 다시 하나의 tuple로 합쳐져서 방출됨.
            .do(onNext: { (vc, data) in
                vc.listTableView.deselectRow(at: data.1, animated: true)
            })
            .map { $1.0 }
            .bind(to: viewModel.detailAction.inputs) // 이렇게 하면 선택한 메모가 action으로 전달되고, action에 구현되어 있는 코드가 실행됨.
            .disposed(by: rx.disposeBag)
        
        listTableView.rx.modelDeleted(Memo.self) // 삭제와 연관된 컨트롤 이벤트를 구독하면 swipeToDelete가 자동으로 활성화 됨.
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
