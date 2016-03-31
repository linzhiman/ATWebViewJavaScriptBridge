//
//  ViewController.m
//  demo
//
//  Created by linzhiman on 16/3/31.
//  Copyright © 2016年 linzhiman. All rights reserved.
//

#import "ViewController.h"
#import "ATWebViewJavaScriptBridge.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ATWebViewJavaScriptBridge *bridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _bridge = [ATWebViewJavaScriptBridge bridgeForWebView:_webView webViewDelegate:nil];
    [_bridge registerAction:[[ATWebViewJavaScriptBridgeTestAction alloc] init]];
    
    NSURL *testUrl = [ATWebViewJavaScriptBridgeTestAction testUrl];
    [_webView loadRequest:[NSURLRequest requestWithURL:testUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
