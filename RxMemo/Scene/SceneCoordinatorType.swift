//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
