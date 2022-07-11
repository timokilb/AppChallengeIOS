//
//  ViewModel.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 08.07.22.
//

import Foundation
import Alamofire
import RxSwift
import RxRelay


class ViewModel {
    
    
    var cellViewModels = BehaviorRelay<[CellViewModel]>(value: [])
    

    init() {
        print(" did init the view model ")
    }
    
    
    func viewControllerDidSet() {
        
    }
    
    
    func cellViewModel(for indexPath: IndexPath) -> CellViewModel? {

    }
    
    
    
    func numberOfRows(in section: Int) -> Int {
        return section > 0 ? 0 : cellViewModels.value.count
    }
    
    
    
    func populate(from wiki: WikiResponse) {
        cellViewModels.accept(wiki.entries.map { CellViewModel(entry: $0) })
    }
    
    
    
    
    func call(_ searchString: String, limit: Int) {

        let url = "https://en.wikipedia.org/w/api.php"
        let parameters: [String: Any] = [
            "action": "opensearch"
        ]
        
        AF.request(url, parameters: parameters).responseDecodable(of: WikiResponse.self) { response in
            print("this is response \(response)")
            guard let wiki = response.value else {
                print("returning!")
                return }
            self.populate(from: wiki)
        }

    }
    
    
    
    
    
}

