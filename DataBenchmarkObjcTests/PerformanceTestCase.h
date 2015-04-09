//
// Created by Stanislav on 09.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

static const NSString *testString = @"test";

@interface PerformanceTestCase : XCTestCase

- (void)measureInBackgroundForCode: (void(^)())block;

@end