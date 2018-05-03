//
//  Tweet.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

struct TweetData: Codable {
    var user: User
    var text: String? = ""
    
    struct User: Codable {
        var name: String?
        var screenName: String?
        var imageURLString: String?
        
        private enum CodingKeys: String, CodingKey {
            case name = "name"
            case screenName = "screen_name"
            case imageURLString = "profile_image_url_https"
        }
    }
}
