//
// Created by Stanislav on 15.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerformanceTestCase.h"
#import "YALRandom.h"


@interface DictionaryHelper : NSObject


+ (NSMutableDictionary *)generateDictionary:(NSUInteger)elementCount;

+ (NSString *)randomDictionaryIndex:(NSDictionary *)dict;

+ (NSString *)randomDictionaryElement:(NSDictionary *)dict randomIndex:(NSString *)randomIndex;
@end