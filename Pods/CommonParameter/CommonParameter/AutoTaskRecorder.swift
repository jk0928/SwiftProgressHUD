//
//  AutoTaskRecorder.swift
//  CommonParameterDemo
//
//  Created by YJHou on 2016/9/7.
//  Copyright © 2016年 侯跃军 GitHub:https://github.com/YJManager/CommonParameter. All rights reserved.
//

import UIKit

public protocol AutoTaskProtocol: NSObjectProtocol {
    func cancel()
}

/**
 用于记录发起的任务（比如网络请求），如果在对象被销毁时任务还未执行完毕，这些任务将被取消并销毁
 */
class AutoTaskRecorder: NSObject {
    
    var unfinishedTasks = NSHashTable<AnyObject>.weakObjects()
    
    func add(task: AutoTaskProtocol) {
        self.unfinishedTasks.add(task)
    }
    
    private func cancelUnfinishedTasks() {
        if let tasks = self.unfinishedTasks.objectEnumerator().allObjects as? [AutoTaskProtocol] {
            for task in tasks {
                task.cancel()
            }
        }
    }
    deinit {
        self.cancelUnfinishedTasks()
    }
}

public extension NSObject {
    // MARK: - TaskRecoder
    /// 记录发起的任务，自动创建任务记录器
    /// 会在对象销毁时取消并清空所有已记录且尚未执行完毕的任务
    public func record(task: AutoTaskProtocol) {
        
        if self.taskRecorder == nil {
            self.taskRecorder = AutoTaskRecorder()
        }
        self.taskRecorder!.add(task: task)
    }
    
    private struct AssociatedKeys {
        static var TaskRecorderKey = "com.houmanager.AutoTaskRecorderKey"
    }
    
    private var taskRecorder: AutoTaskRecorder? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.TaskRecorderKey) as? AutoTaskRecorder
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.TaskRecorderKey, newValue as AutoTaskRecorder?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

