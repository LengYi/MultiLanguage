//
//  LanguageSetViewController.swift
//  MultiLanguage
//
//  Created by zj-db1140 on 2018/11/7.
//  Copyright © 2018年 ice. All rights reserved.
//

import UIKit

class LanguageSetViewController: UIViewController {
    var listTableView: UITableView?
    var lastIndexPath: IndexPath?
    
    let dataArr = [("language0", "ZHCN", "zh-Hans", 0), ("language1", "EN", "en", 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        lastIndexPath = self.configLastIndexPatch()
        
        listTableView = UITableView.init(frame: self.view.frame, style: .plain)
        listTableView?.delegate = self
        listTableView?.dataSource = self
        listTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        self.view.addSubview(listTableView!)
    }
    
    func configLastIndexPatch() -> IndexPath {
        let fileName = Language.current()
        var index = 1
        if fileName == "zh-Hans" {
            index = 0
        }
        
        return IndexPath.init(row: index, section: 0)
    }
    
    func cellCheckMarkImageView() -> UIImageView {
        return UIImageView.init(image: UIImage.init(named: "icNext"))
    }
    
    // 重置App的rootViewController更新界面,实现App内多语言的切换
    func reStartApp() {
        NotificationCenter.default.post(name: NSNotification.Name.init("ReStartApp"), object: nil)
    }
}

extension LanguageSetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify: String = "LanguageCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        let item = dataArr[indexPath.row]
        cell.textLabel?.text = Language.string(key: item.0)
        if lastIndexPath?.row == indexPath.row {
            cell.accessoryView = self.cellCheckMarkImageView()
        } else {
            cell.accessoryView = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lastIndexPath?.row != indexPath.row {
            let lastCell = tableView.cellForRow(at: self.lastIndexPath!)
            lastCell!.accessoryView = nil
            
            let cell = tableView.cellForRow(at: indexPath)
            cell!.accessoryView = self.cellCheckMarkImageView()
            self.lastIndexPath = indexPath
            
            // 存储当前语言类型
            let item = self.dataArr[indexPath.row]
            Language.changeLanguageResourceFileName(fileName: item.2)
            
            self.reStartApp()
        } else {
            let cell = tableView.cellForRow(at: self.lastIndexPath!)
            cell!.accessoryView = self.cellCheckMarkImageView()
        }
    }
}
