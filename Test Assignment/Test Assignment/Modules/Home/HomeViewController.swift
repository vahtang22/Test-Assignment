//
//  HomeViewController.swift
//  Test Assignment
//
//  Created by Max Ivanets on 3/8/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private var posts: [Post] = []
    private var after = ""
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadPosts()
    }
    
    func view() -> HomeView {
        return view as! HomeView
    }
}

extension HomeViewController {
    func configureView() {
        title = "Home"
        
        view().tableView.delegate = self
        view().tableView.dataSource = self
        view().tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        view().tableView.register(PostNoImageTableViewCell.self, forCellReuseIdentifier: "cellNoImage")
        view().tableView.estimatedRowHeight = 100
        view().tableView.rowHeight = UITableView.automaticDimension
        view().refreshControll.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
    }
    
    @objc func loadPosts() {
        view().refreshControll.beginRefreshing()
        NetworkService.shared.getPosts { [weak self] response in
            self?.posts = response.children
            self?.after = response.after
            self?.view().refreshControll.endRefreshing()
            self?.view().tableView.reloadData()
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Post image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = posts[indexPath.row]
        if item.haveImage() {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PostTableViewCell {
                let item = posts[indexPath.row]
                cell.content.title.text = item.title
                cell.content.comments.text = "comments: \(item.num_comments)"
                cell.content.createdAt.text = item.author + ", posted " + item.formattedDate()
                if let url = URL.init(string: item.thumbnail) {
                    cell.content.image.load(url: url)
                }
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cellNoImage") as? PostNoImageTableViewCell {
                let item = posts[indexPath.row]
                cell.content.title.text = item.title
                cell.content.comments.text = "comments: \(item.num_comments)"
                cell.content.createdAt.text = item.author + ", posted " + item.formattedDate()
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
            let save = UIAlertAction.init(title: "Save Photo", style: .default) { [unowned self] _ in
                if let image = cell.content.image.image {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
            let open = UIAlertAction.init(title: "Open Photo", style: .default) { [unowned self] _ in
                let item = self.posts[indexPath.row]
                if let url = URL.init(string: item.thumbnail) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(save)
            alertController.addAction(open)
            alertController.addAction(cancel)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let last = posts.count - 1
        if indexPath.row == last {
            NetworkService.shared.getPosts(after: after) { [weak self] response in
                response.children.forEach {
                    self?.posts.append($0)
                }
                self?.after = response.after
                self?.view().tableView.reloadData()
            }
        }
    }
}

