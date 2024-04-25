//
//  ViewController.swift
//  DemoJSONList
//
//  Created by Mac on 25/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var currentPage = 1
    let limit = 10 // Number of items per page
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "POSTS"
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        guard let url = makeURL() else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let data):
                do {
                    let fetchedPosts = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.posts.append(contentsOf: fetchedPosts)
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    private func makeURL() -> URL? {
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(limit)"
        return URL(string: urlString)
    }
    
    func loadMoreDataIfNeeded(at indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
            currentPage += 1
            fetchData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < posts.count else {
            print("Invalid row selected")
            return
        }
        let selectedPost = posts[indexPath.row]
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            print("Unable to instantiate DetailViewController from storyboard")
            return
        }
        detailViewController.post = selectedPost
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            loadMoreDataIfNeeded(at: IndexPath(row: posts.count - 1, section: 0))
        }
    }
}
