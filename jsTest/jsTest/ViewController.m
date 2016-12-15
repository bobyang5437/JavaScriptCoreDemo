//
//  ViewController.m
//  jsTest
//
//  Created by yang on 2016/12/6.
//  Copyright © 2016年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyObject.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webview;
@property (nonatomic, strong) JSContext* context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIWebView* webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"db" withExtension:@"html"];
//    url = [NSURL URLWithString:@"https://www.baidu.com"];
    self.webview = webview;
    [self.view addSubview:webview];
    webview.delegate = self;
    [webview loadRequest:[NSURLRequest requestWithURL:url]];

    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIWebviewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //初始化content
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"%@",exception);
    };
    self.context[@"testP"] = [[MyObject alloc] init];
    
    //测试oc调js
    NSString* js = @"function add(a,b) {return a + b}";
    [self.context evaluateScript:js];
    JSValue* n = [self.context[@"add"] callWithArguments:@[@2,@3]];
    NSLog(@"%d",[n toInt32]);
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    NSString* jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:jsStr];
    JSValue* result = [self.context[@"factorial"] callWithArguments:@[@10]];
    NSLog(@"factorial is %d",[result toInt32]);
    
    //测试js调oc
    self.context[@"nslog"] =^(NSString* str) {
        NSLog(@"%@",str);
    };
    
    self.context[@"alert"] = ^(NSString* str ) {
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"测试" message:str delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [al show];
    };
    
//    [webView stringByEvaluatingJavaScriptFromString:@"showAlert('it is a test!')"];
    self.context[@"relog"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
    };
    
    [self.context evaluateScript:@"relog('ider', [7, 21], { hello:'world', js:100 });"];
   
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
