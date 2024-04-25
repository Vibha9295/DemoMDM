//
//  PostCell.swift
//  DemoJSONList
//
//  Created by Mac on 25/04/24.
//

import UIKit

class PostCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the selection style
        selectionStyle = .none
    }
    func configure(with post: Post) {
        textLabel?.text = "\(post.id) - \(post.title)"
    }
}
