//
//  NSDictionary+JSONSafeGet.h
//  apptemplate
//
//  Created by linzhiman on 16/3/30.
//  Copyright © 2016年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONSafeGet)

- (NSInteger)integerSafeGet:(id)aKey;
- (uint32_t)unsignedIntSafeGet:(id)aKey;
- (uint64_t)unsignedLongLongSafeGet:(id)aKey;

- (int)intValueSafeGet:(id)aKey;
- (long)longValueSafeGet:(id)aKey;
- (long long)longLongValueSafeGet:(id)aKey;
- (float)floatValueSafeGet:(id)aKey;
- (double)doubleValueSafeGet:(id)aKey;
- (BOOL)boolValueSafeGet:(id)aKey;

- (NSNumber *)numberSafeGet:(id)aKey;

- (NSString *)stringSafeGet:(id)aKey;
- (NSArray *)arraySafeGet:(id)aKey;
- (NSDictionary *)dictionarySafeGet:(id)aKey;

- (NSString *)notNilStringGet:(id)key; //nil -> @""
- (NSArray *)notNilArrayGet:(id)key; //nil -> @[]
- (NSDictionary *)notNilDictionaryGet:(id)key; //nil -> @{};

@end
