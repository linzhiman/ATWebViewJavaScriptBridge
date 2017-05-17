//
//  ATWebViewJavaScriptBridge.m
//  apptemplate
//
//  Created by linzhiman on 16/3/30.
//  Copyright © 2016年 apptemplate. All rights reserved.
//

#import "ATWebViewJavaScriptBridge.h"
#import "ATHttpUtils.h"
#import "NSDictionary+JSONSafeGet.h"

NSString * const ATWebViewJavaScriptBridgeJSCode = @";(function(){if(window.appJavaScriptBridge){return;};window.appJavaScriptBridge=new Object();var callNative=function(url){var iframe=document.createElement('iframe');iframe.style.display='none';iframe.setAttribute('src',url);document.documentElement.appendChild(iframe);iframe.parentNode.removeChild(iframe);iframe=null;};window.appJavaScriptBridge.callNative=function(command,argument){var url='ATAppJavaScriptBridge://'+command+'/'+argument;callNative(url);};window.appJavaScriptBridge.callJavaScript=function(command,argument,callback){if(callback.length>0){var callbackFun=window.appJavaScriptBridge[callback];callbackFun(command,argument);}};||customJavaScriptCode||})();";
#define CheckCurrentWebView(returnValue) \
    if (webView != _webView) { return returnValue; }

@interface ATWebViewJavaScriptBridge ()

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) id<UIWebViewDelegate> webViewDelegate;
@property (nonatomic, strong) NSMutableArray *actions;

@end

@implementation ATWebViewJavaScriptBridge

- (void)dealloc
{
    _webView.delegate = nil;
    _webView = nil;
    _webViewDelegate = nil;
}

- (void)bridgeForWebView:(UIWebView*)webView webViewDelegate:(id<UIWebViewDelegate>)webViewDelegate
{
    _webView = webView;
    _webViewDelegate = webViewDelegate;
    _webView.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    CheckCurrentWebView(YES)
    
    if ([self handleJavaScriptCallWithRequest:request]) {
        return NO;
    }
    
    if ([_webViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        [_webViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    CheckCurrentWebView()
    
    [self insertAppServiceScript];
    
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_webViewDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CheckCurrentWebView()
    
    [self insertAppServiceScript];
    
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_webViewDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    CheckCurrentWebView()
    
    if ([_webViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [_webViewDelegate webView:webView didFailLoadWithError:error];
    }
}

- (void)insertAppServiceScript
{
        [_webView stringByEvaluatingJavaScriptFromString:jsCode];
    }
}

- (BOOL)handleJavaScriptCallWithRequest:(NSURLRequest *)request
{
    if ([[request.URL scheme] isEqualToString:[@"ATAppJavaScriptBridge" lowercaseString]]) {
        NSString *description = [ATHttpUtils urlDecode:[request.URL description]];
        return YES;
    }
    return NO;
}

- (void)registerAction:(id<ATWebViewJavaScriptBridgeAction>)action
{
    if (!_actions) {
        _actions = [[NSMutableArray alloc] init];
    }
    action.bridge = self;
    [_actions addObject:action];
}

- (void)callJavaScriptWithCommand:(NSString *)command argument:(NSDictionary *)argument callback:(NSString *)callback
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:argument options:NSJSONWritingPrettyPrinted error:nil];
    NSString *argumentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.appJavaScriptBridge.callJavaScript('%@', %@, '%@')", command, argumentString, callback ? callback : @""]];
}

+ (instancetype)bridgeForWebView:(UIWebView*)webView webViewDelegate:(id<UIWebViewDelegate>)webViewDelegate
{
    ATWebViewJavaScriptBridge* bridge = [[[self class] alloc] init];
    [bridge bridgeForWebView:webView webViewDelegate:webViewDelegate];
    return bridge;
}

@end

@implementation ATWebViewJavaScriptBridgeTestAction

- (NSString *)command
{
    return @"GetSomething";
}

- (void)actionWithArgument:(NSDictionary *)argument callback:(NSString *)callback
{
    if (self.bridge) {
        [self.bridge callJavaScriptWithCommand:@"onGetSomething" argument:@{@"argument":argument} callback:callback];
    }
}

+ (NSURL *)testUrl
{
    return [[NSBundle mainBundle] URLForResource:@"ATWebViewJavaScriptBridge" withExtension:@"html"];
}

@end
