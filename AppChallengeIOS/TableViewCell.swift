//
//  TableViewCell.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 08.07.22.
//

import Foundation
import UIKit
import RxSwift

class TableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var viewModel: CellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "hello"
        return label
    }()
    
    func bindViewModel() {
        viewModel?.title.subscribe(onNext: { string in
            self.label.text = string
        }).disposed(by: self.disposeBag)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Initializing a cell")
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}
