//
//  ViewController.swift
//  MultiLanguage
//
//  Created by zj-db1140 on 2018/11/7.
//  Copyright © 2018年 ice. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Language.string(key: "nav_title")
        
        let nameLabel = UILabel.init(frame: CGRect(x: 50, y: 100, width: 200, height: 40))
        nameLabel.textColor = UIColor.red
        nameLabel.text = Language.string(key: "test_name")
        self.view.addSubview(nameLabel)
        
        let titleLabel = UILabel.init(frame: CGRect(x: 50, y: 150, width: 200, height: 40))
        titleLabel.textColor = UIColor.red
        titleLabel.text = Language.string(key: "test_title")
        self.view.addSubview(titleLabel)
        
        let button = UIButton.init(frame: CGRect(x: 50, y: 200, width: 200, height: 40))
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitle(Language.string(key: "test_jump"), for: .normal)
        button.addTarget(self, action: #selector(buttonClickAction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func buttonClickAction(_ button: UIButton) {
        let vcc = LanguageSetViewController()
        self.navigationController?.pushViewController(vcc, animated: true)
    }
}

