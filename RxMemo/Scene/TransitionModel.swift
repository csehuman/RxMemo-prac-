//
//  TransitionModel.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}


