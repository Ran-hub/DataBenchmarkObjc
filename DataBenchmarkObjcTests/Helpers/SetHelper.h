//
// Created by Stanislav on 15.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SetHelper : NSObject
+ (NSMutableSet *)generateSet:(NSUInteger)elementCount;

+ (NSUInteger)randomSetIndex:(NSSet *)set;

+ (NSString *)randomSetElement:(NSSet *)set randomIndex:(NSUInteger)randomIndex;
@end