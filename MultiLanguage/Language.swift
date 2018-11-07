//
//  LanguageHandler.swift
//  International
//
//  Created by zj-db1140 on 2018/2/5.
//  Copyright © 2018年 zj-db1140. All rights reserved.
//

import Foundation

let kLanguageResourceFileName: String = "LanguageResourceFileName"    // 当前使用的多语言资源文件

class Language {
    static func string(key: String) -> String {
        return self.string(key: key, comment: "")
    }
    
    static func string(key: String, comment: String) -> String {
        let path: String? = Bundle.main.path(forResource: self.current(), ofType: "lproj")
        guard let resourceBundle  = Bundle.init(path: path!) else {
            return ""
        }
        return resourceBundle.localizedString(forKey: key, value: "", table: nil)
    }
    
    static func isChinese() -> Bool {
        let language = self.current()
        
        if language == "zh-Hans" {
            return true
        }
        
        return false
    }
    
    /*
     获取当前App使用的多语言文件名
     用户已经设置多语言则使用用户多语言配置,否则使用系统的多语言配置
     */
    static func current() -> String {
        guard let fileName: String = UserDefaults.standard.string(forKey: kLanguageResourceFileName) else {
            let languageFileName: String = self.configLanguageResourceFileName()
            UserDefaults.standard.set(languageFileName, forKey: kLanguageResourceFileName)
            return languageFileName
        }
        return fileName
    }
    
    static func currentToH5() -> String {
        let str = self.current()
        if str == "zh-Hans" {
            return "zh"
        }
        return str
    }
    
    /*
     修改当前App使用的多语言文件
     */
    static func changeLanguageResourceFileName(fileName: String) {
        // 添加容错处理，避免异常
        if fileName == "en" || fileName == "zh-Hans" {
            UserDefaults.standard.set(fileName, forKey: kLanguageResourceFileName)
        }
    }
    
    /*
     根据系统语言配置多语言文件名
     */
    static func configLanguageResourceFileName() -> String {
        let systemLanguage = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: systemLanguage) {
        case "en-US", "en-CN":
            return "en"         //英文
        case "zh-Hans-US", "zh-Hans-CN", "zh-Hant-CN", "zh-TW", "zh-HK", "zh-Hans":
            return "zh-Hans"    //中文
        default:
            return "en"
        }
    }
}
