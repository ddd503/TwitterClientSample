//
//  AppDelegate.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let consumerKey = "開発者サイトで作成したTwitterKit用のconsumerKey"
    private let consumerSecret = "開発者サイトで作成したTwitterKit用のconsumerSecret"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        if TWTRTwitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        return false
    }
}
