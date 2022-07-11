//
//  Model.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 08.07.22.
//

import Foundation

struct WikiResponse: Decodable {
    let searchString: String
    let entries: [WikiEntry]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        searchString = try container.decode(String.self)
        let titles = try container.decode([String].self)
        _ = try container.decode([String].self)
        
        entries = Array(zip(titles, links)).map { WikiEntry(title: $0, link: $1) }

    }
    
    init(from data: Data) throws {
        let decoder = JSONDecoder()
        searchString = try decoder.decode(WikiResponse.self, from: data).searchString
        entries = try decoder.decode(WikiResponse.self, from: data).entries
        
    }
}

struct WikiEntry: Decodable {
    let title: String
    let link: String?
    
    init(title: String, link: String?) {
        self.title = title
        self.link = link
    }
}
