//
//  TweetCell.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Kingfisher
import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak private  var profileImageView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var screenNameLabel: UILabel!
    @IBOutlet weak private var tweetMessegeLabel: UILabel!
    
    var profileImageURLString: String? {
        didSet {
            if
                let profileImageURLString = profileImageURLString,
                let profileImageURL = URL(string: profileImageURLString) {
                profileImageView.kf.setImage(with: profileImageURL)
            }
        }
    }
    
    var userNameText: String? {
        didSet {
            userNameLabel.text = userNameText
        }
    }
    
    var screenNameText: String? {
        didSet {
            screenNameLabel.text = screenNameText
        }
    }
    
    var tweetMessegeText: String? {
        didSet {
            tweetMessegeLabel.text = tweetMessegeText
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

