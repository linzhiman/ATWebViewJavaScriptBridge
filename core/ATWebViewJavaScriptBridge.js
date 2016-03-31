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

  //callback = function(command, argument);
    //command = String of command, e.g. 'onGetSomething'
    //argument = JSON, e.g. {result:0}
  window.appJavaScriptBridge.setCallback = function(callback) {
    window.appJavaScriptBridge.callback = callback;
  }
  //command = String of command, e.g. 'GetSomething'
  //argument = JSON, e.g. {test:123456789}
  window.appJavaScriptBridge.callNative = function(command, argument) {
    var jsonString = JSON.stringify(argument);
    var url = 'ATAppJavaScriptBridge://' + command + '/' + jsonString;
    callNative(url);
  }

  window.appJavaScriptBridge.callJavaScript = function(command, argument) {
    window.appJavaScriptBridge.callback(command, argument);
  }
})();
