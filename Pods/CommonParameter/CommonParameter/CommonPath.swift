//
//  CommonPath.swift
//  CommonParameterDemo
//
//  Created by YJHou on 2016/9/7.
//  Copyright © 2016年 侯跃军 GitHub:https://github.com/YJManager/CommonParameter. All rights reserved.
//

import UIKit
import MobileCoreServices

fileprivate let yj_fileManager: FileManager = FileManager.default

/// 获取沙盒(Documents)路径
public let kYJ_DOCUMENTS_PATH: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

/// 获取沙盒(Library)路径
public let kYJ_LIBRARY_PATH: String = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]

/// 获取沙盒(Cache)路径
public let kYJ_CACHE_PATH: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]

/// 获取沙盒(Temp)路径
public let kYJ_TEMP_PATH: String = NSTemporaryDirectory()

/// 文件或者文件夹是否存在
public func yj_fileExist(path: String) -> Bool{
    return yj_fileManager.fileExists(atPath: path)
}

/// 创建路径
public func yj_createDirectory(path: String) -> Bool {
    try? yj_fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    if yj_fileExist(path: path) {
        return true
    }else{
        return false
    }
}

/// 获取沙盒 Application Support 路径，不存在时会自动创建
public func yj_applicationSupport() -> String {
    let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]
    if !yj_fileExist(path: path) {
        _ = yj_createDirectory(path: path)
    }
    return path
}

/// 根据名称获取Bundle 默认为 nil，表示 main bundle
public func yj_bundleFormName(name: String? = nil) -> Bundle? {
    if name == nil {
        return Bundle.main
    }
    return Bundle(identifier: name!)
}

/// 文件是否存在以及是否是文件
public func yj_fileExistAndIsFile(path: String) -> (exist: Bool, isFile: Bool) {
    var isDirectory = ObjCBool(false)
    let exist = yj_fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
    return (exist, isDirectory.boolValue)
}

/// 文件扩展名
public func yj_pathExtension(_ path: String) -> String? {
    let path = path as NSString
    return path.pathExtension
}

/// 获取文件 mime type
public func yj_mimeType(path: String) -> String? {
    if let ext = yj_pathExtension(path) as NSString? {
        if let UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext, nil)?.takeUnretainedValue() {
            if let MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType) {
                let mimeTypeCFString = MIMEType.takeUnretainedValue() as CFString
                return mimeTypeCFString as String
            }
        }
    }
    return nil
}

// MARK: - Private
private func _fileSize(_ path: String) -> UInt64 {
    let fileExist = yj_fileExistAndIsFile(path: path)
    if fileExist.exist && fileExist.isFile {
        if let attributes = try? yj_fileManager.attributesOfItem(atPath: path) as NSDictionary {
            return attributes.fileSize()
        }
    }
    return 0
}

private func _folderSize(_ path: String) -> UInt64 {
    var folderSize: UInt64 = 0
    
    let fileExist = yj_fileExistAndIsFile(path: path)
    if fileExist.exist && !fileExist.isFile {
        if let contents = try? yj_fileManager.contentsOfDirectory(atPath: path) {
            for file in contents {
                let path = file
                let subFileExist = yj_fileExistAndIsFile(path: path)
                if subFileExist.exist {
                    if subFileExist.isFile {
                        folderSize += _fileSize(path)
                    }else {
                        folderSize += _folderSize(path)
                    }
                }
            }
        }
    }
    return folderSize
}

/// 获取文件大小，如果是文件夹，会遍历整个目录及子目录计算所有文件大小
public func yj_sizeOfPath(_ path: String) -> UInt64 {
    let fileExist = yj_fileExistAndIsFile(path: path)
    if fileExist.exist {
        if fileExist.isFile {
            return _fileSize(path)
        }else {
            return _folderSize(path)
        }
    }
    return 0
}

/// 转换字节数为最大单位可读字符串
public func yj_bytesString(_ bytes: UInt64) -> String {
    let kb = Double(bytes)/1024;
    if (kb < 1) {
        return "\(bytes)B"
    }
    let mb = kb/1024.0;
    if (mb < 1) {
        return String(format: "%.0fKB", kb)
    }
    let gb = mb/1024.0;
    if (gb < 1) {
        return String(format: "%.1fMB", mb)
    }
    let tb = gb/1024.0;
    if (tb < 1) {
        return String(format: "%.1fG", gb)
    } else {
        return String(format: "%.1fT", tb)
    }
}




