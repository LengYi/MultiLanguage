//
//  AppDelegate.swift
//  MultiLanguage
//
//  Created by zj-db1140 on 2018/11/7.
//  Copyright © 2018年 ice. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setViewController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetRootViewController), name: NSNotification.Name(rawValue: "ReStartApp"), object: nil)
        
        return true
    }

    func setViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        let rootVC = HomeViewController()
        window.rootViewController = UINavigationController(rootViewController: rootVC)
        self.window = window
    }

    @objc fileprivate final func resetRootViewController() {
        guard let window = self.window else {
            return
        }
       
        let rootVC = HomeViewController()
        rootVC.modalTransitionStyle = .crossDissolve
        UIView.transition(with: window, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            let oldStatus = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: rootVC)
            UIView.setAnimationsEnabled(oldStatus)
        }, completion: nil)
    }
}

