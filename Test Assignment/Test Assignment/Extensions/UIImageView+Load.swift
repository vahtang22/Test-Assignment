//
//  UIImageView+Load.swift
//  Test Assignment
//
//  Created by Max Ivanets on 3/9/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
