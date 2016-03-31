//
//  ATHttpUtils.h
//  apptemplate
//
//  Created by linzhiman on 5/6/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATHttpUtils : NSObject

+ (NSString *)urlEncode:(NSString *)urlString;
+ (NSString *)urlDecode:(NSString *)urlString;

@end
