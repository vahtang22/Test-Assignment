//
//  HomeView.swift
//  Test Assignment
//
//  Created by Max Ivanets on 3/8/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class HomeView: UIView {
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let refreshControll = UIRefreshControl()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addFullSizeSubView(view: tableView)
        tableView.addSubview(refreshControll)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
