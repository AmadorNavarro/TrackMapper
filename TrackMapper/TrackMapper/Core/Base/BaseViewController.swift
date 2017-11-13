//
//  BaseViewController.swift
//  Droppit
//
//  Created by Amador Navarro on 18/10/2017.
//  Copyright © 2017 Amador Navarro. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<VM: BaseViewModel>: UIViewController, BaseViewControllerDelegate {
    
    var viewModel: VM!
    var scrollView: UIScrollView!
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = createViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupLayout()
        setupRx()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetTitle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if scrollView != nil {
            scrollView.setContentOffset(.zero, animated: false)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewWillAppear()
        setupTitle()
        
        if scrollView != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    func setupViewModel() {
        viewModel.setup(withPresenter: self)
    }
    
    func setupRx() {
        disposeBag = DisposeBag()
    }
    
    func setupLayout() {
        edgesForExtendedLayout = .bottom
    }
    
    /// Override and return a presenter in a subclass.
    func createViewModel() -> VM {
        preconditionFailure("VMMV method `createViewModel()` must be override in a subclass and do not call `super.createViewModel()`!")
    }
    
    /// Override this method to initialize the Navigation Bar Title
    func navBarTitle() -> String {
        return ""
    }
    
    /// Override this method to initialize the Navigation Bar Title and hide the Navigation Bar if the title isEmpty otherwise show it
    func setupTitle() {
        title = navBarTitle()
        navigationController?.isNavigationBarHidden = title?.isEmpty ?? true
    }
    
    private func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue, let scrollView = scrollView else { return }
        
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom = adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom = adjustmentHeight
    }
    
    private func resetTitle() {
        title = ""
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        adjustInsetForKeyboardShow(show: true, notification: notification)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
}
