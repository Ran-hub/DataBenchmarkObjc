//
// Created by Stanislav on 15.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArrayHelper : NSObject
+ (NSMutableArray *)generateArray:(NSUInteger)elementCount;

+ (NSUInteger)randomArrayIndex:(NSArray *)array;

+ (NSString *)randomArrayElement:(NSArray *)array randomIndex:(NSUInteger)randomIndex;
@end