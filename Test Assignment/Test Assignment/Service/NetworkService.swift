//
//  NetworkService.swift
//  Test Assignment
//
//  Created by Max Ivanets on 3/8/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {
    }
    
    func getPosts(after: String = "", success: ((PostList) -> Void)?) {
        var path = ""
        if after.isEmpty {
            path = "https://www.reddit.com/top.json"
        } else {
            path = "https://www.reddit.com/top.json?after=\(after)"
        }
        let url = URL(string: path)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let response = try JSONDecoder().decode(PostList.self, from: unwrappedData)
                DispatchQueue.main.async {
                    success?(response)
                }
            } catch {
                print("json error: \(error)")
            }
        }
        task.resume()
    }
}
