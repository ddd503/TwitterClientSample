//
//  Users.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import TwitterKit
import UIKit

struct Users {
    static let session = TWTRAPIClient(userID: TWTRTwitter.sharedInstance().sessionStore.session()?.userID)
}
