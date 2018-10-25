//
//  UINavigationBarExt.swift
//  YJExtensionsGather
//
//  Created by YJHou on 2016/9/7.
//  Copyright © 2016年 侯跃军 GitHub:https://github.com/YJManager/YJExtensions . All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    /// 定义导航栏的全局颜色
    public class func customizeAppearenceColorWith(barTint: UIColor, foreground: UIColor) {
        
        self.appearance().barTintColor = barTint
        self.appearance().tintColor = foreground
        self.appearance().textColor = foreground
    }
    
    /// 设置导航栏的文字颜色
    public var textColor: UIColor? {
        get {
            return self.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
        }
        set {
            var attributes = self.titleTextAttributes ?? [NSAttributedStringKey.foregroundColor : UIColor()]
            attributes[NSAttributedStringKey.foregroundColor] = newValue
            self.titleTextAttributes = attributes
        }
    }
    
    /// 设置导航栏标题的字体
    public var titleFont: UIFont? {
        get {
            return self.titleTextAttributes?[NSAttributedStringKey.font] as? UIFont
        }
        set {
            var attributes = self.titleTextAttributes ?? [NSAttributedStringKey.font : UIFont()]
            attributes[NSAttributedStringKey.font] = newValue
            self.titleTextAttributes = attributes
        }
    }
}
