//
//  ViewController.m
//  FFWebBridgeDemo
//
//  Created by ixiazer on 16/2/23.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()
@property WebViewJavascriptBridge* bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_bridge) { return; }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];

    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    __weak typeof(self) this = self;
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        [this h5ActionHandle:data];
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [self loadExamplePage:webView];
}

- (void)h5ActionHandle:(id)data {
//    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
