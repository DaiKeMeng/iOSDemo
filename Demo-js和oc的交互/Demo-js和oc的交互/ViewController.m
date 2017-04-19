//
//  ViewController.m
//  Demo-js和oc的交互
//
//  Created by 代克孟 on 2017/4/19.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "ViewController.h"
// 拿取JSContext js运行的环境
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic ,strong) UIWebView* webView;
@property (nonatomic ,strong) JSContext* context;

@end

@implementation ViewController
/*********一般都是html文件里面调用js的代码或者文件******************/
/**    oc调用js
       都要在加载成功以后才能调用js的信息
        
       1. 获取js运行环境的上下文
       self.context  = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
       2. 创建js的代码，一定要在web开发工具上走一次，不然语法错误无法执行的。 （悲伤脸）
        NSString* scriptString = @"var addElementsAction = function (name){var a = document.createElement('p');a.innerHTML=name + '，你好啊';document.getElementsByTagName('body')[0].appendChild(a)}";
       3. 创建js的代码加载运行环境中
        [self.context evaluateScript:scriptString];
       4. 运用JSValue来获取oc和js中事件的绑定
        JSValue*value1 = self.context[@"addElementsAction"];
       5. 执行JS的方法，如果没有参数就直接空数组，有参数，要按顺利添加到数组中
        [value1 callWithArguments:@[@"小明"]];
*/

/**    js调用oc
方法一:跟前端商定好，在需要调用oc的代码的时候发送出来一个请求，请求的内容自定义，然后根据请求内容从而决定调用oc的方法
      - (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
        获取出request的url    
       **************此方法我感觉有点low****************
 
方法二: 调用JavaScriptCore框架（这个框架是iOS7以后才出的，获取当前webView的js运行环境，进而可以对一些js的方法进行监听，然后在触发的时候调用oc代码
       **************必须在加载成功以后才能调用js****************
        
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor whiteColor];
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 60)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"点我调用js的信息" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(presentLogResourceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.webView                = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 500)];
    NSString *path  = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL  = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"jsToOc"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    self.webView.delegate       = self;
    [self.view addSubview:self.webView];
}

// 点击调用js的代码
-(void)presentLogResourceAction
{
    // oc调用js，或者js调用oc其实都是双向的才能实现效果
    /**  oc直接调用js的方法
    NSString* scriptString = @"var addElementsAction = function (name){var a = document.createElement('p');a.innerHTML=name + '，你好啊';document.getElementsByTagName('body')[0].appendChild(a)}";
    [self.context evaluateScript:scriptString];
    JSValue*value1 = self.context[@"addElementsAction"];
    [value1 callWithArguments:@[@"小明"]];
     */
    
    /** js直接调用oc的方法
    self.context[@"jsToOcAction"] = ^(void){
        NSLog(@"在这里调用oc的方法");
    };
     */
}

// webView加载请求的时候，拦截加载webView页面加载的请求，从而断定是否进行加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // **************根据urlString的不同调用的oc方法**************
    NSString* urlString = [[request URL] absoluteString];
    NSLog(@"urlString :: %@",urlString);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        // 加载的请求其实就是链接类型，比如a标签的href  window.location.reload(url)
    }else if (navigationType == UIWebViewNavigationTypeReload){
        // 加载的请求重新刷新本页面，比如window.location.reload()
        
    }else if (navigationType == UIWebViewNavigationTypeBackForward){
        // 加载的请求返回上一个页面，不能运用js的window.history(-1),因为这个是浏览器自身的缓存栈的数据，不涉及发送request
        
    }else if (navigationType == UIWebViewNavigationTypeFormSubmitted){
        // 加载的请求提交数据请求，一般是form标签的submitted 提交
        
    }else if (navigationType == UIWebViewNavigationTypeFormResubmitted){
        //
    }else if (navigationType == UIWebViewNavigationTypeOther){
        // 其他的一些请求链接
    }
    return YES;
}

// webView开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

// webView加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //***********************注意，这段代码一定要在webView加载成功以后才能调用*********************
    // 拿取js的运行环境
    self.context  = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 拿取js文件中的某个方法
//    self.context[@"helloName"] = ^(void){
//        NSLog(@"oc调用js的代码");
//    };
  

//    [self.context evaluateScript:@"var a = document.createElement('p');a.innerHTML='小伙子，你好啊'document.getElementsByTagName('body')[0].appendChild(a)"];
//    [webView stringByEvaluatingJavaScriptFromString:@"var a = document.createElement('p');a.innerHTML='小伙子，你好啊'document.getElementsByTagName('body')[0].appendChild(a)"];
//    [self.context evaluateScript:@"var a = document.createElement('p');a.innerHTML='小伙子，你好啊'document.getElementsByTagName('body')[0].appendChild(a)"];
//     拿取当前webView加载的页面的js的运行环境
//    self.context  = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  
//    // 拿取js文件中的某个方法
//    JSValue *function = context[@"printHello"];
//    // 运行js的方法 后面的数组是方法带的参数
//    [function callWithArguments:@[]];
}
// webView加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}



@end
