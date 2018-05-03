//
//  TimeLineController.swift
//  skillup_test_kawahara_0317
//
//  Created by kawaharadai on 2018/03/17.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import SVProgressHUD
import UIKit

class TimeLineController: UIViewController {
    
    @IBOutlet weak private var homeTimeLine: UITableView!
    private let timeLineDao = TimeLineDao()
    private let provider = TimeLineProvider()
    private let acount = Acount()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !Acount.loginStatus() {
            acount.loginAction()
            return
        }
        reloadTimeLine()
    }
    
    private func setup() {
        acount.delegate = self
        timeLineDao.delegate = self
        homeTimeLine.dataSource = provider
        refreshControl.addTarget(self, action: #selector(TimeLineController.refresh(sender:)), for: .valueChanged)
        homeTimeLine.refreshControl = refreshControl
    }
    
    private func reloadTimeLine() {
        timeLineShow()
        timeLineDao.getTimeLine()
    }
    
    private func timeLineShow() {
        homeTimeLine.isHidden = true
        SVProgressHUD.show()
    }
    
    private func timeLineDismiss() {
        homeTimeLine.isHidden = false
        SVProgressHUD.dismiss()
    }
    
    private func showCreateDataSourceErrorAlert(title: String?) {
        let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.reloadTimeLine()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showLoginErrorAlert(title: String?) {
        let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.acount.loginAction()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        if !Acount.loginStatus() {
            acount.loginAction()
            return
        }
        self.timeLineDao.getTimeLine()
    }
}

extension TimeLineController: AcountDelegate {
    func loginSuccess() {
        reloadTimeLine()
    }
    
    func loginFailure() {
        self.showLoginErrorAlert(title: "ログインに失敗しました。\n再度ログインしてください。")
    }
}

extension TimeLineController: TimeLineDaoDelegate {
    
    func gotHomeLine(data: [TweetData]) {
        provider.userTweet = data
        DispatchQueue.main.async {
            self.homeTimeLine.reloadData()
            self.timeLineDismiss()
            self.refreshControl.endRefreshing()
        }
    }
    
    func failure() {
        self.showCreateDataSourceErrorAlert(title: "データソース作成に失敗しました。")
    }
    
    func offlineError() {
        self.showCreateDataSourceErrorAlert(title: "通信環境の良い場所で再度お試しください。")
    }
}

