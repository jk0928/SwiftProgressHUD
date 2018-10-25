//
//  AutoPinyinIndexer.swift
//  CommonParameterDemo
//
//  Created by YJHou on 2016/9/7.
//  Copyright © 2016年 侯跃军 GitHub:https://github.com/YJManager/CommonParameter. All rights reserved.
//

import UIKit

/// 拼音索引器，将指定的对象数组按照指定属性进行拼音首字母排序并创建索引
public class AutoPinyinIndexer<T: NSObject>: NSObject {
    
    private var objectList: [T]
    private var propertyName: String
    
    /// 处理完毕的对象数组，按索引分组
    open var indexedObjects = [[T]]()
    /// 处理完毕的索引数组（拼音首字母）
    open var indexedTitles = [String]()
    
    /// 创建索引器实例
    ///
    /// - Parameters:
    ///   - objects: 需要索引的对象数组
    ///   - property: 索引依据的属性键值，属性必须为 String 类型
    public init(objects: [T], property: String) {
        objectList = objects
        propertyName = property
        super.init()
        
        self.indexObjects()
    }
    
    private func indexObjects() {
        
        // 按索引分组
        let theCollation = UILocalizedIndexedCollation.current()
        let indexArray = [AutoPinyinIndex<T>]();
        
        for object in self.objectList {
            let index = AutoPinyinIndex(fromObject: object, property: propertyName)
            let section = theCollation.section(for: index, collationStringSelector: #selector(AutoPinyinIndex.pinyin))
            index.sectionNumber = section
        }
        
        let sortedIndexArray = indexArray.sorted { (index1, index2) -> Bool in
            return index1.name > index2.name
        }
        
        let sectionCount = theCollation.sectionTitles.count
        
        for i in 0 ..< sectionCount {
            var sectionArray = [T]()
            for j in 0 ..< sortedIndexArray.count {
                let index = sortedIndexArray[j]
                if index.sectionNumber == i {
                    sectionArray.append(index.object)
                }
            }
            if sectionArray.count > 0 {
                indexedObjects.append(sectionArray)
                indexedTitles.append(theCollation.sectionTitles[i])
            }
        }
    }
}

public class AutoPinyinIndex<T: NSObject>: NSObject {
    
    var object: T
    var name: String
    var sectionNumber: Int = 0
    
    init(fromObject obj: T, property: String) {
        object = obj
        if let propertyValue = obj.value(forKey: property) as? String {
            name = propertyValue
        }else {
            name = ""
        }
    }
    
    @objc func pinyin() -> String {
        return name.pinyin(.firstLetter)
    }
}

fileprivate extension String {
    
    /// 拼音的类型
    fileprivate enum PinyinType {
        case normal         // 默认类型，不带声调
        case withTone       // 带声调的拼音
        case firstLetter    // 拼音首字母
    }
    
    fileprivate func pinyin(_ type: PinyinType = .normal) -> String {
        switch type {
        case .normal:
            return normalPinyin()
        case .withTone:
            return pinyinWithTone()
        case .firstLetter:
            return pinyinFirstLetter()
        }
    }
    
    private func pinyinWithTone() -> String {
        //转换为带声调的拼音
        let nameRef = CFStringCreateMutableCopy(nil, 0, self as CFString!)
        CFStringTransform(nameRef, nil, kCFStringTransformMandarinLatin, false)
        return nameRef! as String
    }
    
    private func normalPinyin() -> String {
        //去除声调
        let nameRef = CFStringCreateMutableCopy(nil, 0, self as CFString!)
        CFStringTransform(nameRef, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(nameRef, nil, kCFStringTransformStripDiacritics, false)
        return nameRef! as String
    }
    
    private func pinyinFirstLetter() -> String {
        let pinyinString = pinyin() as NSString
        return pinyinString.substring(to: 1)
    }
}
