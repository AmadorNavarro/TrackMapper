//
//  BaseViewControllerDelegate.swift
//  Droppit
//
//  Created by Amador Navarro on 18/10/2017.
//  Copyright © 2017 Amador Navarro. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseViewControllerDelegate {
        
    func setupLayout()
    func setupRx()
    func setupViewModel()
    
}
