//
//  Post.swift
//  Test Assignment
//
//  Created by Max Ivanets on 3/8/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

struct PostList: Decodable {
    var children: [Post] = []
    var after = ""
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    enum DataCodingKeys: String, CodingKey {
        case children
        case after
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        
        self.children = try nestedContainer.decode([Post].self, forKey: .children)
        self.after = try nestedContainer.decode(String.self, forKey: .after)
    }
}

struct Post: Decodable {
    var num_comments = 0
    var title = ""
    var created = 0
    var thumbnail = ""
    var author = ""
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    enum DataCodingKeys: String, CodingKey {
        case num_comments
        case title
        case created
        case thumbnail
        case author
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        
        self.num_comments = try nestedContainer.decode(Int.self, forKey: .num_comments)
        self.title = try nestedContainer.decode(String.self, forKey: .title)
        self.created = try nestedContainer.decode(Int.self, forKey: .created)
        self.thumbnail = try nestedContainer.decode(String.self, forKey: .thumbnail)
        self.author = try nestedContainer.decode(String.self, forKey: .author)
    }
    
    func haveImage() -> Bool {
        return !thumbnail.isEmpty && (thumbnail.contains("https") || thumbnail.contains("http"))
    }
    
    func formattedDate() -> String {
        let createdAt = Date.init(timeIntervalSince1970: TimeInterval.init(created))
        let hours = Calendar.current.dateComponents([.hour], from: createdAt, to: Date()).hour ?? 0
        if hours > 0 {
            return "\(hours) hours ago"
        } else {
            return "less than hour ago"
        }
    }
}
