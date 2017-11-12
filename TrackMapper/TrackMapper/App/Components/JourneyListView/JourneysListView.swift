//
//  JourneysListView.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

final class JourneysListView: UIView {
    
    static let headerHeight: CGFloat = 80.0
    static let cornerRadius: CGFloat = 20.0

    let headerButton = UIButton(type: .custom)
    let tableView = UITableView(frame: .zero, style: .plain)
    let viewModel = JourneysListViewModel()
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupRx()
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .white
        layer.cornerRadius = JourneysListView.cornerRadius
        layer.masksToBounds = true
        
        headerButton.backgroundColor = UIColor(white: 0.9, alpha: 0.7)
        headerButton.setTitleColor(.black, for: .normal)
        headerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        addSubview(headerButton)
        headerButton.snp.remakeConstraints { [weak self] make in
            guard let `self` = self else { return }
            
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(JourneysListView.headerHeight)
        }
        
        addSubview(tableView)
        tableView.snp.remakeConstraints { [weak self] make in
            guard let `self` = self else { return }
            
            make.top.equalTo(headerButton.snp.bottom)
            make.leading.equalTo(headerButton)
            make.trailing.equalTo(headerButton)
            make.bottom.equalTo(self)
        }
    }
    
    func setupRx() {
        disposeBag = DisposeBag()
        
        viewModel.buttonTitle.bind(to: headerButton.rx.title()).addDisposableTo(disposeBag)
        
        headerButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.viewModel.buttonAction.execute()
        }).addDisposableTo(disposeBag)
    }
    
    func setupTableView() {
        tableView.register(UINib.init(nibName: "JourneyCell", bundle: nil), forCellReuseIdentifier: "JourneyCell")
    }
    
}
