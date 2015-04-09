//
// Created by Stanislav on 09.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YALRandom : NSObject
+ (int)intFrom:(int)from to:(int)to;

+ (double)doubleFrom:(double)from to:(double)to;

+ (BOOL)boolValue;

+ (BOOL)boolValueWithProbability:(double)prob;

+ (id)oneFrom:(NSArray *)array;
@end