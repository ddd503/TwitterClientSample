//
//  TimeLineProvider.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class TimeLineProvider: NSObject {
    var userTweet = [TweetData]()
}

extension TimeLineProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTweet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier,
                                                       for: indexPath) as? TweetCell else {
                                                        fatalError("セル作成に失敗しました。")
        }
        
        cell.profileImageURLString = userTweet[indexPath.row].user.imageURLString
        cell.userNameText = userTweet[indexPath.row].user.name
        cell.screenNameText = userTweet[indexPath.row].user.screenName
        cell.tweetMessegeText = userTweet[indexPath.row].text
        
        return cell
    }
}
