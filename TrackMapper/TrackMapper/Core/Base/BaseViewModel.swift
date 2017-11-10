//
//  BaseViewModel.swift
//  Droppit
//
//  Created by Amador Navarro on 18/10/2017.
//  Copyright © 2017 Amador Navarro. All rights reserved.
//

import Foundation
import RxSwift
import Action

enum FormError: Error {
    
    case invalidEmail, invalidPassword, invalidRepeatPassword, emptyName, emptyNameLastName, emptyLastName, emptyPassword, emptyEmail, emptyRepeatPassword, differentPassword, emptyAddress, emptyFloor, emptyProvince, emptyCity, emptyPostalCode, emptyState, emptyCardHolder, emptyCardNumber, emptyCvv2, emptyMonthYear
    
}

class BaseViewModel {
    // FIXME: Check if in swift 4 private/interal work
    var wireframe = BaseWireframe()
    var disposeBag = DisposeBag()
    
    let reloadAction = CocoaAction { return .empty() }
    let actionSuccess: Action<Any?, Any?> = Action { element in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    let formValidationAction: Action<(FormError, String), (FormError, String)> = Action { element in
        return Observable.create({ (observer) -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    func setup(withPresenter presenter: UIViewController) {
        wireframe.presenterViewController = presenter
    }
    
    /// Override this method if you want to do something in the viewWillAppear of the ViewController
    func onViewWillAppear() {
    }
    
}
