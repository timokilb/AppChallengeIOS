//
//  ViewController.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 06.07.22.
//

import UIKit
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    let cellIdentifier: String = "TableViewCellIdentifier"

    var viewModel: ViewModel? {
        didSet {
            self.bindViewModel()
            viewModel?.viewControllerDidSet()
        }
    }
    
    lazy var textField: UITextField = {
        let input = UITextField()
        
        input.placeholder = "Search Wikipedia"
        
        input.borderStyle = .roundedRect
        return input
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
    
        return table
    }()
    
    lazy var fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
        
    }()
    
    // TODO: Get only from 3 letters +
    @objc func handleButtonTapped() {
        if let string = self.textField.text {
            
            let result = string.replacingOccurrences(of: " ", with: "+")
            viewModel?.call(result, limit: 10)
        } else { print("Something went wrong stirng is empty") }
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the
        self.view.backgroundColor = .white
        self.setupViews()
    }
    
    func presentWebViewController(for link: String) {
        let url = URL(string: link)
        let webViewController = WebViewController()
        webViewController.url = url!
        self.present(webViewController, animated: true)
    }
    
    // TODO: RxSwift implementation
    func bindViewModel() {
        viewModel?.cellViewModels.subscribe(onNext: { model in
            // Show files
        })
        
    }
    
    func setupViews() {
        self.view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        self.view.addSubview(fetchButton)
        fetchButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(48)
        }
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.bottom.equalTo(fetchButton.snp.top).offset(-16)
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = viewModel?.numberOfRows(in: section) ?? 0
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TableViewCell
        cell.viewModel = viewModel?.cellViewModel(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entry = tableView.cellForRow(at: indexPath) as? TableViewCell,
              let link = entry.viewModel?.entry.link
        else { return }
        self.presentWebViewController(for: link)
        
        
        
    }
    
}
