//
//  SecondViewController.m
//  Demo-js和oc的交互
//
//  Created by 代克孟 on 2017/4/19.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "SecondViewController.h"
#import <WebKit/WebKit.h>

@interface SecondViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic ,strong) WKWebView* wkWebView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController* contentC = [[WKUserContentController alloc] init];
    // oc调用js的方法
    /**
     [webView evaluateJavaScript:js的代码 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"成功了");
        }else{
            NSLog(@"调用失败error: %@",error);
        }
     }];
    */

    // js调用oc
    // 方法一：通过自定义URL方法
    
    // 方法二：
    // 这段代码的意思是在js中添加一个modele的类，以后js向oc传递消息可以用
    // window.webkit.messageHandlers.modele.postMessage({body:发送的消息})
    // 发送的消息的意思就是要实现的某种方法
    // 注意，messageHandler必须是遵守WKScriptMessageHandler协议
    // 在wkWebView消失的时候记得移除
    [contentC addScriptMessageHandler:self name:@"modele"];
    configuration.userContentController = contentC;
    
    self.wkWebView                      = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    NSString* pathString    = [[NSBundle mainBundle] bundlePath];
    NSURL* sourceUrl        = [NSURL fileURLWithPath:pathString];
    NSString* htmlPath      = [[NSBundle mainBundle] pathForResource:@"jsToOc" ofType:@"html"];
    NSString * htmlCont     = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.wkWebView loadHTMLString:htmlCont baseURL:sourceUrl];
    self.wkWebView.navigationDelegate   = self;
    self.wkWebView.UIDelegate           = self;
    [self.view addSubview:self.wkWebView];
}

#pragma mark - WKScriptMessageHandler
// 处理数据，处理js推给webview的数据 message.body  类型包括 number string array dictionary null类型
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"didReceiveScriptMessage : %@",message.body);
}

#pragma mark - WKNavigationDelegate
/**   当加载请求的时候，在navigationAction中能抓取请求的类型(navigationType)，请求(request)
 * program
 * program
 * program decisionHandler 是否处理这个请求 
    WKNavigationActionPolicyAllow       允许
    WKNavigationActionPolicyCancle      取消
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    // url如果是大写的话，要变成小写的，webView在加载的时候会把大写字母转换成小写的
    if ([navigationAction.request.URL.absoluteString isEqualToString:@"dkm:///getCameraAction"]) {
        NSLog(@"js调用oc去开启相机");
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
/**   当获取服务器的响应的时候， navigationResponse中的响应(response)
 * program
 * program
 * program  decisionHandler 是否处理
   WKNavigationResponsePolicyAllow
   WKNavigationResponsePolicyCancel
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**         开始加载请求的时候
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}
/**         开始接受到服务器的返回结果的时候
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}
/**         加载请求失败
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}
/**         提交合并请求
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    
}
/**         完成请求，得到全部的结果以后
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    // 一定要在加载完成后执行js的代码
    NSString* javaString = @"var a = document.createElement('p');a.innerHTML=name + '，你好啊';document.getElementsByTagName('body')[0].appendChild(a)";
    [webView evaluateJavaScript:javaString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"成功了");
        }else{
            NSLog(@"调用失败error: %@",error);
        }
    }];
}
/**         发送请求失败
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}
/**         接收到认证信息的处理
 * program
 * program
 * program
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    
}


@end
