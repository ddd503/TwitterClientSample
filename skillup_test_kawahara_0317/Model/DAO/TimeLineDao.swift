//
//  TimeLineDao.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Alamofire
import TwitterKit
import UIKit

protocol TimeLineDaoDelegate: class {
    func offlineError()
    func gotHomeLine(data: [TweetData])
    func failure()
}

class TimeLineDao {
    
    weak var delegate: TimeLineDaoDelegate?
    private let endPoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    
    static func isReachable() -> Bool {
        
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
    
    /// TwtterKitを使用してタイムラインデータを取得
    func getTimeLine() {
        let client = Users.session
        let statusesShowEndpoint = endPoint
        let params = ["count": "20"]
        var clientError: NSError?
        
        guard TimeLineDao.isReachable() else {
            self.delegate?.offlineError()
            return
        }
        
        let request = client.urlRequest(withMethod: "GET",
                                        urlString: statusesShowEndpoint,
                                        parameters: params,
                                        error: &clientError)
        
        client.sendTwitterRequest(request) { _, data, connectionError -> Void in
            if connectionError != nil {
                print(connectionError as Any)
                self.delegate?.failure()
            }
            
            guard let jsonData = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tweetData = try decoder.decode([TweetData].self, from: jsonData)
                self.delegate?.gotHomeLine(data: tweetData)
            } catch let error {
                print(error)
                self.delegate?.failure()
            }
        }
    }
}
