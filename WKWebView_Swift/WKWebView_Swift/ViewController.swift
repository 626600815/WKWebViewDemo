//
//  ViewController.swift
//  WKWebView_Swift
//
//  Created by mainone on 16/4/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate, UIAlertViewDelegate {
    
    var URLToLaunchWithPermission: NSURL!
    
    
    deinit {
        self.webview.removeObserver(self, forKeyPath: "loading")
        self.webview.removeObserver(self, forKeyPath: "title")
        self.webview.removeObserver(self, forKeyPath: "estimatedProgress")
        
        self.webview.removeFromSuperview()
        self.progressView.removeFromSuperview()
        self.webview.UIDelegate = nil
        self.webview.navigationDelegate = nil
        self.alertView.delegate = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载网页
        self.webview.loadRequest(NSURLRequest(URL:NSURL(string: "http://m.baidu.com")!))
        
        
        //监听属性
        self.webview.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        self.webview.addObserver(self, forKeyPath: "title", options: .New, context: nil)
        self.webview.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        //设置前进后退
        let leftItem = UIBarButtonItem(title: "后退", style: .Done, target: self, action: #selector(ViewController.previousPage))
        
        let closeItem = UIBarButtonItem(title: "关闭", style: .Done, target: self, action: #selector(ViewController.closePage))
        self.navigationItem.leftBarButtonItems = Array(arrayLiteral: leftItem, closeItem)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "前进", style: .Done, target: self, action: #selector(ViewController.nextPage))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - KVO
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            self.progressView.alpha = 1.0
            let animated: Bool = Float(self.webview.estimatedProgress) > self.progressView.progress
            self.progressView.setProgress(Float(self.webview.estimatedProgress), animated: animated);
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animateWithDuration(0.3, delay: 0.3, options: .CurveEaseInOut, animations: { 
                    self.progressView.alpha = 0.0
                    }, completion: { (finished) in
                        self.progressView.setProgress(0.0, animated: false)
                })
            }
        } else if keyPath == "title" {
            self.title = self.webview.title;
        } else if keyPath == "loading" {
            print("loading");
        }
    }
    
    
    //MARK: - WKScriptMessageHandler
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
       
    }
    
    //MARK: - WKNavigationDelegate
    
    //决定导航的动作，通常用于处理跨域的链接是否导航，webkit对跨域进行安全检查，不允许出现跨域
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        let URL: NSURL = navigationAction.request.URL!
        if !self.externalAppRequiredToOpenURL(URL) {
            if (navigationAction.targetFrame == nil) {
                self.webview.loadRequest(NSURLRequest(URL: URL))
                decisionHandler(.Cancel)
                return
            }
        } else if UIApplication.sharedApplication().canOpenURL(URL) {
            self.launchExternalAppWithURL(URL)
            decisionHandler(.Cancel)
            return
        }
        
         decisionHandler(.Allow);
    }
    
    //决定是否允许导航相应，如果不允许就不会跳转到该链接的页面
    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.Allow)
    }
    
    //页面内容开始加载
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    //接收到服务器跳转请求之后调用
    func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
       
    }
    
    //网页内容加载失败
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        
    }
    
    //页面内容到达mainFrame的时候调用（若想在mainFrame中注入js代码也可在此方法中添加）
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        
    }
    
    //页面内容完成加载
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
       
    }
    
    //接收内容发生错误
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
       
    }
    
    //若我们的请求需要授权、证书等，需处理此方法
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
         completionHandler(.PerformDefaultHandling, nil)
    }
    
//    //终止页面加载 (iOS 9.0 )
//    func webViewWebContentProcessDidTerminate(webView: WKWebView) {
//        print(#function)
//    }
    
    //MARK: - WKUIDelegate
    
    //创建一个新的WebVIew
    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return nil
    }
    
    //通知应用程序正常关闭（iOS 9.0）
    func webViewDidClose(webView: WKWebView) {
        
    }
    
    //弹出警告框
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        
    }
    
    //弹出确认框
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {
        
    }
    
    //弹出输入框
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String?) -> Void) {
        
    }
    
    //MARK: - UIAlertViewDelegate
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if alertView == self.alertView {
            if buttonIndex != alertView.cancelButtonIndex {
                UIApplication.sharedApplication().openURL(self.URLToLaunchWithPermission)
            }
            self.URLToLaunchWithPermission = nil
        }
    }
    
    //MARK: - 方法
    
    func previousPage() {
        if self.webview.canGoBack {
            self.webview.goBack()
        }
    }
    
    func nextPage() {
        if self.webview.canGoForward {
            self.webview.goForward()
        }
    }
    
    func closePage() {
        let backForwardList = self.webview.backForwardList
        let index = backForwardList.backList.count
        if index > 0 {
            let item = backForwardList.itemAtIndex(-index)
            self.webview.goToBackForwardListItem(item!)
        }else {
            
        }
    }
    
    //外部应用程序打开URL
    func externalAppRequiredToOpenURL(URL: NSURL) -> Bool {
        let validSchemes = NSSet(arrayLiteral: "http", "https")
        return !validSchemes.containsObject(URL.scheme)
    }
    
    func launchExternalAppWithURL(URL: NSURL) {
        self.URLToLaunchWithPermission = URL
        self.alertView.show()
        
    }
    
    //MARK: - 初始化
    
    lazy var webview: WKWebView = {
        let webV = WKWebView(frame: self.view.bounds, configuration: self.configuretion)
        webV.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.addSubview(webV)
        webV.navigationDelegate = self
        webV.UIDelegate = self
        print("我创建了你")
        return webV
    }()
    
    lazy var configuretion: WKWebViewConfiguration = {
        let configuretion = WKWebViewConfiguration()
        
        //webview的偏好设置
        configuretion.preferences = WKPreferences()
        configuretion.preferences.minimumFontSize = 10
        configuretion.preferences.javaScriptEnabled = true
        
        //默认不通过js自动打开窗口的，必须用户交互才能打开
        configuretion.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        //通过js与webview内容交互配置
        configuretion.userContentController = WKUserContentController()
        return configuretion
    }()
    
    lazy var progressView: UIProgressView = {
        let progressV = UIProgressView(progressViewStyle: .Default)
        progressV.autoresizingMask = [.FlexibleWidth, .FlexibleHeight, .FlexibleTopMargin]
        progressV.frame = CGRectMake(0, self.navigationController!.navigationBar.frame.size.height - progressV.frame.size.height, self.view.frame.size.width, progressV.frame.size.height)
        progressV.trackTintColor = UIColor.whiteColor()
        progressV.progressTintColor = UIColor.orangeColor()
        self.navigationController!.navigationBar.addSubview(progressV)
        return progressV;
    }()

    lazy var alertView: UIAlertView = {
        let alertV = UIAlertView(title: "提示", message: "这网页试图打开外部应用。你确定你想要打开它吗?", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "前往")
        alertV.delegate = self
        return alertV
    }()
    
}

