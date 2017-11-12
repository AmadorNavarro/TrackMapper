//
//  JourneyCell.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import UIKit
import RxSwift

final class JourneyCell: UITableViewCell {
    
    static let preferredHeight: CGFloat = 50.0
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    var viewModel = JourneyCellViewModel()
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
        setupRx()
    }
    
    func setupLayout() {
        
        startLabel.font = UIFont.systemFont(ofSize: 14)
        endLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func setupRx() {
        disposeBag = DisposeBag()
        
        viewModel.startTitle.bind(to: startLabel.rx.text).addDisposableTo(disposeBag)
        viewModel.endTitle.bind(to: endLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func set(viewModel: JourneyCellViewModel) {
        self.viewModel = viewModel
        setupLayout()
        setupRx()
    }
    
}
