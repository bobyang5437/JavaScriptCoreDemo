//
//  ViewController.m
//  jsTest
//
//  Created by yang on 2016/12/6.
//  Copyright © 2016年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIWebView* webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIWebView* webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"db" withExtension:@"html"];
    self.webview = webview;
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];

    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
