//
// Created by Stanislav on 09.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

static const NSString *testString = @"test";
static const NSInteger attemptsCount = 10;
static const NSInteger maxElementsInStructure = 500;

@interface PerformanceTestCase : XCTestCase

- (void)performTimeTestWithPrepareBlock:(id(^)(NSInteger count))prepareBlock operationBlock:(NSTimeInterval (^)(id))operationBlock structureName:(NSString *)structureName operationName:(NSString *)operationName;

- (void)performTimeTestWithPrepareBlock:(id(^)(NSInteger count))prepareBlock operationBlock:(NSTimeInterval (^)(id, id, id))operationBlock randomIndexBlock:(id(^)(id))randomIndexBlock randomElementBlock:(id(^)(id, id))randomElementBlock structureName:(NSString *)structureName operationName:(NSString *)operationName;
@end