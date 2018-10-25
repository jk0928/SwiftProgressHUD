//
//  CommonParameter.swift
//  CommonParameterDemo
//
//  Created by YJHou on 2016/9/7.
//  Copyright © 2016年 侯跃军 GitHub:https://github.com/YJManager/CommonParameter. All rights reserved.
//

import UIKit

// MARK: - 屏幕尺寸 / Screen size

/// 屏幕的宽度 / Screen width
public let kSCREEN_WIDTH    = Double(UIScreen.main.bounds.width)

/// 屏幕的高度 / Screen height
public let kSCREEN_HEIGHT   = Double(UIScreen.main.bounds.height)


// MARK: - Software信息 / Software information

/// APP BundleDisplayName
public let kBUNDLE_DISPLAY_NAME = (Bundle.main.infoDictionary!)["CFBundleDisplayName"] as? String

/// APP Bundle Identifier
public let kBUNDLE_IDENTIFIER = (Bundle.main.infoDictionary!)["CFBundleIdentifier"] as! String

/// APP 版本号 / BundleShortVersion
public let kAPP_VERSION = (Bundle.main.infoDictionary!)["CFBundleShortVersionString"] as! String

/// APP 编译版本号 / Build
public let kAPP_BUILD_VERSION = (Bundle.main.infoDictionary!)["CFBundleVersion"] as! String

// MARK: - UserDefaults
public let kUSER_DEFAULT = UserDefaults.standard

// MARK: - 通知中心 / NotificationCenter
public let kNotificationCenter = NotificationCenter.default

// MARK: - 判断是不是plus
public let kCURRENT_MODE_SIZE = UIScreen.main.currentMode?.size
//let kIS_PLUS = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))?(CGSize(width: 1242.0, height: 2208.0).equalTo(kCURRENT_MODE_SIZE!)):false

// MARK: - 设备信息 /Device information

/// 设备唯一标识号UUID
public let kDEVICE_UUID = UIDevice.current.identifierForVendor?.uuidString

/// 系统信息/ systemVersion information
public let kDEVICE_NAME = UIDevice.current.name
public let kDEVICE_MODEL = UIDevice.current.model // e.g. @"iPhone", @"iPod touch"
public let kDEVICE_LOCALIZED_MODEL = UIDevice.current.localizedModel
public let kDEVICE_SYSTEM_NAME = UIDevice.current.systemName
public let kDEVICE_SYSTEM_VERSION = (UIDevice.current.systemVersion as NSString).doubleValue

/// 设备型号 iPhone 1,2  模拟器 x86_64 / Equipment type
public var kDEVICE_MODEL_ALL: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8 , value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
}



////////////////////////// 功能 Function ///////////////////////
// MARK: - Alert
public func showAlertView(title: String, message: String){
    let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "取消")
    alert.show()
}

// MARK: - 电话
/// 电话呼叫
///
/// - Parameters:
///   - phone: 被叫方的电话号码
///   - immediately: 是否跳过确认提示 默认需要确认
/// - Return: 不支持电话功能时返回 false
@discardableResult public func call(_ phone: String, immediately: Bool = false) -> Bool {
    let typeString = immediately ? "tel" : "telprompt"
    if let callURL = URL(string: typeString + "://" + phone),
        UIApplication.shared.canOpenURL(callURL) {
        UIApplication.shared.openURL(callURL)
        return true
    }
    return false
}











