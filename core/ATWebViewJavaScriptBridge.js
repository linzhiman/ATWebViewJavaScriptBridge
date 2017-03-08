;(function() {
  if (window.appJavaScriptBridge) { return; }
  window.appJavaScriptBridge = new Object();
  
  function callNative(url) {
    var iframe = document.createElement('iframe');
    iframe.style.display = 'none';
    iframe.setAttribute("src", url);
    document.documentElement.appendChild(iframe);
    iframe.parentNode.removeChild(iframe);
    iframe = null;
  }

  //command = String of command, e.g. 'GetSomething'
  //argument = String of JSON, e.g. '{test:123456789}'
  window.appJavaScriptBridge.callNative = function(command, argument) {
    var url = 'ATAppJavaScriptBridge://' + command + '/' + argument;
    callNative(url);
  }

  window.appJavaScriptBridge.callJavaScript = function(command, argument, callback) {
    if (callback.length > 0) {
      var callbackFun = window.appJavaScriptBridge[callback];
      callbackFun(command, argument);
    }
  }
})();
