//
//  PostTableViewCell.swift
//  Test Assignment
//
//  Created by Max Ivanets on 3/9/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    let content: PostView = {
        let view = PostView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addFullSizeSubView(view: content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        content.image.image = nil
        content.title.text = nil
        content.createdAt.text = nil
        content.comments.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class PostNoImageTableViewCell: UITableViewCell {
    let content: PostView = {
        let view = PostView(hideImage: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addFullSizeSubView(view: content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        content.image.image = nil
        content.title.text = nil
        content.createdAt.text = nil
        content.comments.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class PostView: UIView {
    let title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    let createdAt: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    let comments: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init(hideImage: Bool = false) {
        self.init(frame: .zero, hideImage: hideImage)
    }
    
    init(frame: CGRect, hideImage: Bool = false) {
        super.init(frame: frame)
        addSubview(title)
        if !hideImage {
            addSubview(image)
        }
        addSubview(comments)
        addSubview(createdAt)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(constraints)
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
        if image.isDescendant(of: self) {
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
            image.heightAnchor.constraint(equalToConstant: 200).isActive = true
            
            createdAt.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8).isActive = true
        } else {
            createdAt.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        }
        createdAt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        createdAt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        comments.topAnchor.constraint(equalTo: createdAt.bottomAnchor, constant: 8).isActive = true
        comments.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        comments.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        super.updateConstraints()
    }
}
