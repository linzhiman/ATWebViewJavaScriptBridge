# ATWebViewJavaScriptBridge

## App与WebView页面交互规范

1、App在WebView注入一个对象window.appJavaScriptBridge。 

2、页面JavaScript调用Native  

    window.appJavaScriptBridge.callNative(command, argument);
    如果需要App回调，需将callback函数挂在window.appJavaScriptBridge，函数名自定义，如callbackName，并在argument中添加字段'callback':'callbackName'；
    其中callback为 function callbackName(command, argument)；  

3、Native调用页面JavaScript  

    window.appJavaScriptBridge.callback(command, argument);  

4、参数说明  

    command为 String，标记需要调用的方法；  
    argument为 String，内容为JSON对象，调用方法需要的参数；App回调时为JSON对象；  

5、示例  

    ATWebViewJavaScriptBridge.html  

## 使用

1、将core中的文件加入工程  
2、加入头文件  

    #import "ATWebViewJavaScriptBridge.h”  

3、新建属性或变量持有bridge对象  

    @property (nonatomic, strong) ATWebViewJavaScriptBridge *bridge;  

4、创建bridge对象，会将webView的delegate设置为bridge对象，bridge对象处理完再回调webViewDelegate，webViewDelegate可以为空  

    _bridge = [ATWebViewJavaScriptBridge bridgeForWebView:_webView webViewDelegate:nil];  

5、注册处理动作，每个页面调用实现一个Action，可以添加多个Action  

    [_bridge registerAction:[[ATWebViewJavaScriptBridgeTestAction alloc] init]];  

6、加载测试页面  

    NSURL *testUrl = [ATWebViewJavaScriptBridgeTestAction testUrl];  
    [_webView loadRequest:[NSURLRequest requestWithURL:testUrl]];  

## 备注
1、可将.js代码放在.m中，省去读取文件。

