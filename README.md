# WKWebViewDemo
WKWebView方法总结

###初步探索WKWebView,整理一些常用的方法,待以后用到的时候可以快速地浏览添加到项目中

##功能介绍
利用WKWebView加载网页以及和网页的交互，WKWebView是ios8时推出的一个高性能加载网页的控件，
相对于UIWebView而言，无论是消耗内存还是网页交互都非常的不错

##相关配置

1.添加相应的依赖库WebKit.framework

2.引入头文件#import <WebKit/WebKit.h>

##使用说明

三个常用代理的简单说明  *WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler*

#####WKNavigationDelegate代理

发送请求之前决定是否跳转

    - (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

收到响应后，决定是否跳转

    - (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

接受到服务器跳转请求之后调用

    - (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

开始加载

    - (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

加载失败

    - (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
  
内容开始返回

    - (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

加载完成

    - (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;

接收内容是发生错误

    - (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

终止页面加载（iOS 9.0）

    - (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);


#####WKUIDelegate代理

创建一个新的WebVIew

    - (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

通知应用程序正常关闭（iOS 9.0）

    - (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);

弹出警告框

    - (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;

弹出确认框

    - (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;

弹出输入框

    - (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler;

#####WKScriptMessageHandler代理

从web界面接收到一个脚本是调用

    - (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;


###使用中还存在的问题待解决

同UIWebView缓存的区别，WKWebView不会像UIWebView那样自己记住缓存，在实际开发项目中，会出现项目杀死之后再次打开，获取不到session数据的情况，同UIWebView共同使用时，UIwebView的cookie与WKebView共享的时候会出现首次共享失败的情况

对于WKWebView的缓存处理还有待研究

