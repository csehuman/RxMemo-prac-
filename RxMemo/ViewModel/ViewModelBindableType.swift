//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    // VC에 추가된 ViewModel 속성에 Paramter로 전달된 실제 ViewModel을 저장하고 bindViewModel 호출.
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
