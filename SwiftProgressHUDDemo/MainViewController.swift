//
//  MainViewController.swift
//  SwiftProgressHUDDemo
//
//  Created by YJHou on 2016/3/12.
//  Copyright © 2016年 侯跃军. All rights reserved.
//

import UIKit
import CommonParameter
import YJSwiftExtensions
import Lottie

fileprivate let btnW = 65.0, btnH = 38.0, rightMargin = 10.0, fontSize = 13.0

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        _setUpShowDifferenceMainView()
        
        SwiftProgressHUD.showWait()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController {
    
    func _setUpShowDifferenceMainView() -> () {
        
        let btnVGap = (kSCREEN_HEIGHT - btnH * 9) / 10.0
        let btnFont = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let btnX = kSCREEN_WIDTH - btnW - rightMargin
        
        let showWaitBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "等待", btnFont: btnFont, btnTag: 1)
        view.addSubview(showWaitBtn)
        
        let showSuccessBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH), width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "成功", btnFont: btnFont, btnTag: 2)
        view.addSubview(showSuccessBtn)
        
        let showFailBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 2, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "失败", btnFont: btnFont, btnTag: 3)
        view.addSubview(showFailBtn)
        
        let showInfoBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 3, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "信息提示", btnFont: btnFont, btnTag: 4)
        view.addSubview(showInfoBtn)
        
        let showOnlyTextBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 4, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "文字", btnFont: btnFont, btnTag: 5)
        view.addSubview(showOnlyTextBtn)
        
        let showOnStatusBarBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 5, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "顶部弹出", btnFont: btnFont, btnTag: 6)
        view.addSubview(showOnStatusBarBtn)
        
        let showAnimationImagesClearBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 6, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "透明动画", btnFont: btnFont, btnTag: 7)
        view.addSubview(showAnimationImagesClearBtn)
        
        let showAnimationImagesBgBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 7, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "背景动画", btnFont: btnFont, btnTag: 8)
        view.addSubview(showAnimationImagesBgBtn)
        
        let showLottieBtn = getBtn(frame: CGRect(x: btnX, y: btnVGap + (btnVGap + btnH) * 8, width: btnW, height: btnH), cornerRadius: btnH * 0.5, title: "Lottie", btnFont: btnFont, btnTag: 9)
        view.addSubview(showLottieBtn)

    }
    
    /// 点击事件
    @objc func showBtnActionClick(btn: UIButton) {
        let btnTag = btn.tag
        if btnTag == 1 { // wait
            
            /// 设置蒙版背景颜色, 默认是clear
//            SwiftProgressHUD.hudBackgroundColor = UIColor.black.withAlphaComponent(0.2)
            
            /// 开始loading...
            SwiftProgressHUD.showWait()
            
            /// 模拟 1s后 加载完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SwiftProgressHUD.hideAllHUD()
            }
            
        }else if btnTag == 2 { // success
            
            //SwiftProgressHUD.showSuccess("加载成功加载成功加载成功加载成功加载成功加载成功加载成功加载成功加载成功")
            SwiftProgressHUD.showSuccess("啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", autoClear: true, autoClearTime: 10) {
                print("runable")
            }
            
            /// 模拟 1s后 加载完成
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                SwiftProgressHUD.hideAllHUD()
//            }
        
        }else if btnTag == 3 { // fail
            
            SwiftProgressHUD.showFail("加载失败")
            
            /// 模拟 1s后 加载完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SwiftProgressHUD.hideAllHUD()
            }

        }else if btnTag == 4 { // info
            
            SwiftProgressHUD.showInfo("请稍后")
            
            /// 模拟 1s后 加载完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SwiftProgressHUD.hideAllHUD()
            }
        
        }else if btnTag == 5 { // showOnlyText
            
            SwiftProgressHUD.showOnlyText("请输入合法的手机号")
            
            /// 模拟 1s后 加载完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SwiftProgressHUD.hideAllHUD()
            }
        
        }else if btnTag == 6 { // showOnStatusBar
            
            SwiftProgressHUD.showOnNavigation("你有一条新消息", autoClear: true, autoClearTime: 1, textColor: UIColor.red, fontSize:15, backgroundColor: UIColor.gray)
            
            /// 模拟 1s后 加载完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SwiftProgressHUD.hideAllHUD()
            }
            
        }else if btnTag == 7 { // showAnimationImages
            
            showAnimation(backgroundColor: UIColor.clear)
            
        }else if btnTag == 8 { // 有背景动画
            
            showAnimation(backgroundColor: UIColor.black.withAlphaComponent(0.8), scale: 0.6)
            
        }else if btnTag == 9 { // showLottie
            
            showLottie()
            
        }

    }
    
    fileprivate func showAnimation(backgroundColor: UIColor, scale: Double = 1.0) {
        let animationDuration = 70 // 动画时间 单位毫秒Int
        
        var loadingImages = [UIImage]()
        for index in 0...16 {
            let loadImageName = String(format: "new_brand_progress%02d", index)
            if let loadImage = UIImage(named: loadImageName) {
                loadingImages.append(loadImage)
            }
        }
        
        SwiftProgressHUD.showAnimationImages(loadingImages, timeMilliseconds: animationDuration, backgroundColor: backgroundColor, scale: scale)
        
        /// 模拟 1s后 加载完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            SwiftProgressHUD.hideAllHUD()
        }
    }
    
    
    fileprivate func showLottie() {
        
        let lotWidth = 90.0
        let lotHeight = 90.0
        let lotViewX = (kSCREEN_WIDTH - lotWidth) * 0.5
        let lotViewY = (kSCREEN_HEIGHT - lotHeight) * 0.5
        
        let animationView = LOTAnimationView(name: "lottie_loading")
        animationView.frame = CGRect(x: lotViewX, y: lotViewY, width: lotWidth, height: lotHeight)
        animationView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        animationView.layer.cornerRadius = 5.0
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.play{ (finished) in
            // Do Something
            print("showLottie-Finish")
            animationView.removeFromSuperview()
        }
        
        /// 模拟 1s后 加载完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            animationView.stop()
        }
    }
}

// MARK: - 方法提供
extension MainViewController {
    
    /// 创建btn
    func getBtn(frame: CGRect, cornerRadius: Double, title: String, btnFont: UIFont, btnTag: Int) -> UIButton {
        let btn = UIButton(frame: frame)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = btnFont
        btn.setBackgroundImage(UIImage.yj_createImage(UIColor.yj_randomColor()), for: .normal)
        btn.addTarget(self, action: #selector(showBtnActionClick(btn:)), for: .touchUpInside)
        btn.tag = btnTag
        btn.layer.cornerRadius = CGFloat(cornerRadius)
        btn.layer.masksToBounds = true
        return btn
    }
    
    // MARK: - 状态栏的显示
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .none
    }
    
    // MARK: - 屏幕选装
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    
}






