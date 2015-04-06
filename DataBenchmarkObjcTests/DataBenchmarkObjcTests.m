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
    NSDate *startDate = [NSDate new];
    /* code to estimate you can put here */
     NSDate *endDate = [NSDate new];
    NSTimeInterval operationTime = [endDate timeIntervalSinceDate:startDate];
    NSLog(@"Operation takes %f ms", operationTime * 1000);
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

- (void) testArrayIndexOfSpeed {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
    [self measureBlock: ^{
        [testArray indexOfObject:last];
    }];
}

- (void) testArrayContainSpeed {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
    [self measureBlock: ^{
        [testArray containsObject:last];
    }];
}


#pragma mark - Sets

- (void)testSetWriteSpeed {
    [self measureBlock: ^{
        [self generateSet];
    }];
}

- (void)testSetFastEnumReadSpeed {
    NSMutableSet *testSet = [self generateSet];
    
    [self measureBlock: ^{
        for (NSString *str in testSet) {
            NSString *const constant = str;
        }
    }];
}

- (void)testSetFastEnumDeleteSpeed {
    NSMutableSet *testSet = [self generateSet];
    NSMutableSet *removeSet = [NSMutableSet new];
    [self measureBlock: ^{
        for (NSString *item in testSet) {
            [removeSet addObject:item];
        }
        [testSet minusSet:removeSet];
    }];
}

- (void)testSetContainsSpeed {
    NSMutableSet *testSet = [self generateSet];
    
    NSString *const toFound = [NSString stringWithFormat:@"%@%u", testString, iterationCount - 1];
    [self measureBlock: ^{
        [testSet containsObject:toFound];
    }];
}

//MARK: Dictionaries

- (void)testDictionaryWriteSpeed {
    [self measureBlock: ^{
        [self generateDictionary];
    }];
}

- (void)testDictionaryFastEnumReadSpeed {
    NSMutableDictionary *testDictionary = [self generateDictionary];
    
    [self measureBlock: ^{
        for (NSString *value in testDictionary.allValues) {
            NSString *const constant = value;
        }
    }];
}

- (void)testDictionaryByKeyReadSpeed {
    NSMutableDictionary *testDictionary = [self generateDictionary];
    
    [self measureBlock: ^{
        for (NSUInteger i = 0; i < testDictionary.count; i++) {
            NSString *const constant = testDictionary[[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        }
    }];
}

- (void)testDictionaryByKeyDeleteSpeed {
    NSMutableDictionary *testDictionary = [self generateDictionary];
    
    [self measureBlock: ^{
        for (NSUInteger i = 0; i < testDictionary.count; i++) {
            [testDictionary removeObjectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        }
    }];
}

- (void)testDictionaryContainSpeed {
    NSMutableDictionary *testDictionary = [self generateDictionary];
    
    NSString *const toFound = [NSString stringWithFormat:@"%@%u", testString, iterationCount - 1];
    [self measureBlock: ^{
        [testDictionary.allValues containsObject:toFound];
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

- (NSMutableSet *)generateSet {
    NSMutableSet *testSet = [NSMutableSet new];
    for (NSUInteger i = 0; i < iterationCount; i++) {
        [testSet addObject:[NSString stringWithFormat:@"%@%lu", testString, (unsigned long)i]];
    }
    
    return testSet;
}

- (NSMutableDictionary *)generateDictionary {
    NSMutableDictionary * testDictionary = [NSMutableDictionary new];
    for (NSUInteger i = 0; i < iterationCount; i++) {
        testDictionary[[NSString stringWithFormat:@"%lu", (unsigned long)i]] = [NSString stringWithFormat:@"%@%lu", testString, (unsigned long)i];
    }
    
    return testDictionary;
}



@end
