//
//  DataBenchmarkObjcTests.m
//  DataBenchmarkObjcTests
//
//  Created by Stanislav on 02.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

static const NSUInteger iterationCount = 100000;
static const NSString *testString = @"test";

@interface DataBenchmarkObjcTests : XCTestCase

@end

@implementation DataBenchmarkObjcTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//MARK: Arrays

- (void) testArrayWriteSpeed {
    [self measureBlock: ^{
        [self generateArray];
    }];
}

- (void) testArrayFastEnumReadSpeed {
    NSMutableArray *testArray = [self generateArray];
    
    [self measureBlock: ^{
        for (NSString *str in testArray) {
            NSString *const constant = str;
        }
    }];
}

- (void) testArrayByIndexReadSpeed {
    NSMutableArray *testArray = [self generateArray];
    
    [self measureBlock: ^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            NSString *const constant = testArray[i];
        }
    }];
}

- (void) testArrayByIndexDeleteSpeed {
    NSMutableArray *testArray = [self generateArray];
    
    [self measureBlock: ^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            [testArray removeObjectAtIndex:i];
        }
    }];
}

- (void) testArrayFindSpeed {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
    [self measureBlock: ^{
        [testArray indexOfObject:last];
    }];
}

#pragma mark - Helper methods

 - (NSMutableArray *)generateArray {
     NSMutableArray *testArray = [NSMutableArray new];
    for (NSUInteger i = 0; i < iterationCount; i++) {
        [testArray addObject:[NSString stringWithFormat:@"%@%lu", testString, (unsigned long)i]];
    }
    
    return testArray;
}


@end
