//
//  Acount.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import TwitterKit
import UIKit

protocol AcountDelegate: class {
    func loginSuccess()
    func loginFailure()
}

class Acount {
    
    weak var delegate: AcountDelegate?

    /// ログイン状態の確認
    static func loginStatus() -> Bool {
        if TWTRTwitter.sharedInstance().sessionStore.session() != nil {
            return true
        } else {
            return false
        }
    }
    
    /// ログイン
    func loginAction() {
        TWTRTwitter.sharedInstance().logIn { session, error in
            guard let session = session else {
                if let error = error {
                    print("ログインエラー：\(error.localizedDescription)")
                    self.delegate?.loginFailure()
                }
                return
            }
            print("@\(session.userName)でログインしました")
            self.delegate?.loginSuccess()
        }
    }
}

