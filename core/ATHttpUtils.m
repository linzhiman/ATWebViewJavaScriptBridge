//
//  ATHttpUtils.m
//  apptemplate
//
//  Created by linzhiman on 5/6/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATHttpUtils.h"

@implementation ATHttpUtils

+ (NSString *)urlEncode:(NSString *)urlString
{
    if (urlString == nil) {
        return @"";
    }
    
    if (![urlString isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    CFStringRef originalString = (__bridge  CFStringRef)urlString;
    CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        originalString,
                                                                        NULL,
                                                                        CFSTR(":/?#[]@!$&'()*+,;="),
                                                                        kCFStringEncodingUTF8);
    return (NSString *)CFBridgingRelease(encodedString);
}

+ (NSString *)urlDecode:(NSString *)urlString
{
    NSString *decodeString = [urlString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [decodeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
