//
//  DetailViewController.swift
//  DemoJSONList
//
//  Created by Mac on 25/04/24.
//

// DetailViewController.swift

import UIKit

class DetailViewController: UIViewController {
    var post: Post?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            titleLabel.text = "Post ID: \(post.id)"
            bodyLabel.text = "Post Title: \(post.title)"
        } else {
            print("No post data available")
        }
    }
    
    func performHeavyComputation(for post: Post) -> String {
        print("Performing heavy computation for post with ID: \(post.id)")
        return post.title
    }
}
