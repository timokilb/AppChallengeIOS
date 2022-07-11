//
//  CellViewModel.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 08.07.22.
//

import Foundation
import RxSwift

class CellViewModel {
    
    
    let entry: WikiEntry
    let title = BehaviorSubject<String>(value: "")
    let link = BehaviorSubject<String>(value: "")
    
    init(entry: WikiEntry) {
        self.entry = entry
    }
    
}
