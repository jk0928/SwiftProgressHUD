# <!-- ![](Images/img_0.png)--> CommonParameter

CommonParameter 包含 **Swift 3.0+** 开发中常用的常量、变量以及常用方法等。

### 安装
支持 CocoaPods 安装：

```ruby
  pod 'CommonParameter'
```

### 常量、变量、方法

#### 常量、变量
  1.屏幕的宽高
  2.APP Bundle Identifier
  3.APP 版本号
  4.APP 编译版本号

#### 常用方法
  1.showAlertView()
  2.call()

### 常用路径Path

``` Swift
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
  ......
```

### 自动任务管理器

``` Swift
  public protocol AutoTaskProtocol: NSObjectProtocol {
      func cancel()
  }
  ......
```

### 自动创建拼音索引和排序

``` Swift
  public class AutoPinyinIndexer<T: NSObject>: NSObject {}

  public class AutoPinyinIndex<T: NSObject>: NSObject {}
  ......
```
