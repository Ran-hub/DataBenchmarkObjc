//
//  DataBenchmarkObjcTests.m
//  DataBenchmarkObjcTests
//
//  Created by Stanislav on 02.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "YALLinkedList.h"
#import "YALOptimizedLinkedList.h"
#import "YALStack.h"
#import "YALQueue.h"
#import "PerformanceTestCase.h"
#import "YALRandom.h"

static const NSInteger iterationCount = 10000;
static const NSString *testString = @"test";

@interface DataBenchmarkObjcTests : PerformanceTestCase

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

#pragma mark - Arrays

- (void)testArrayAdd {
    [self performFunctionInBackground:^{
        [self generateArray];
    }];
}

- (void)testArrayUpdate {
    NSMutableArray *testArray = [self generateArray];
    [self performFunctionInBackground:^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            NSInteger randomInt = [YALRandom intFrom:0 to:iterationCount];
            testArray[i] = [NSString stringWithFormat:@"%@%u", testString, randomInt];
        }
    }];
}

- (void)testArrayReadFastEnum {
    NSMutableArray *testArray = [self generateArray];

    [self performFunctionInBackground:^{
        for (NSString *str in testArray) {
            NSString *const constant = str;
        }
    }];
}

- (void)testArrayReadByIndex {
    NSMutableArray *testArray = [self generateArray];

    [self performFunctionInBackground:^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            NSString *const constant = testArray[i];
        }
    }];
}

- (void)testArrayDeleteByIndex {
    NSMutableArray *testArray = [self generateArray];

    [self performFunctionInBackground:^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            [testArray removeObjectAtIndex:i];
        }
    }];
}

- (void)testArrayFindByIndex {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
    [self performFunctionInBackground:^{
        [testArray indexOfObject:last];
    }];
}

- (void)testArrayCheckContain {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
    [self performFunctionInBackground:^{
        [testArray containsObject:last];
    }];
}


#pragma mark - Sets

- (void)testSetAdd {
    [self performFunctionInBackground:^{
        [self generateSet];
    }];
}

- (void)testSetFastEnumRead {
    NSMutableSet *testSet = [self generateSet];

    [self performFunctionInBackground:^{
        for (NSString *str in testSet) {
            NSString *const constant = str;
        }
    }];
}

- (void)testSetDelete {
    NSMutableSet *testSet = [self generateSet];
    NSMutableSet *removeSet = [NSMutableSet new];
    [self performFunctionInBackground:^{
        for (NSString *item in testSet) {
            [removeSet addObject:item];
        }
        [testSet minusSet:removeSet];
    }];
}

- (void)testSetCheckContain {
    NSMutableSet *testSet = [self generateSet];

    NSString *const toFound = [NSString stringWithFormat:@"%@%u", testString, iterationCount - 1];
    [self performFunctionInBackground:^{
        [testSet containsObject:toFound];
    }];
}

#pragma mark - Dictionaries

- (void)testDictionaryAdd {
    [self performFunctionInBackground:^{
        [self generateDictionary];
    }];
}

- (void)testDictionaryUpdate {
    NSMutableDictionary *testDictionary = [self generateDictionary];
    NSMutableDictionary *randomDictionary = [[NSMutableDictionary alloc] initWithCapacity:testDictionary.count];
    for (NSInteger i = 0; i < iterationCount; i++) {
        randomDictionary[[NSString stringWithFormat:@"%d", i]] = [NSString stringWithFormat:@"%@%u", testString, [YALRandom intFrom:0 to:iterationCount]];
    }
    [self performFunctionInBackground:^() {
        for (NSString *key in testDictionary.allKeys) {
            testDictionary[key] = randomDictionary[key];
        }
    }];
}

- (void)testDictionaryReadFastEnum {
    NSMutableDictionary *testDictionary = [self generateDictionary];

    [self performFunctionInBackground:^{
        for (NSString *value in testDictionary.allValues) {
            NSString *const constant = value;
        }
    }];
}

- (void)testDictionaryReadByKey {
    NSMutableDictionary *testDictionary = [self generateDictionary];

    [self performFunctionInBackground:^{
        for (NSUInteger i = 0; i < testDictionary.count; i++) {
            NSString *const constant = testDictionary[[NSString stringWithFormat:@"%lu", (unsigned long) i]];
        }
    }];
}

- (void)testDictionaryDeleteByKey {
    NSMutableDictionary *testDictionary = [self generateDictionary];

    [self performFunctionInBackground:^{
        for (NSUInteger i = 0; i < testDictionary.count; i++) {
            [testDictionary removeObjectForKey:[NSString stringWithFormat:@"%lu", (unsigned long) i]];
        }
    }];
}

- (void)testDictionaryCheckContain {
    NSMutableDictionary *testDictionary = [self generateDictionary];

    NSString *const toFound = [NSString stringWithFormat:@"%@%u", testString, iterationCount - 1];
    [self performFunctionInBackground:^{
        [testDictionary.allValues containsObject:toFound];
    }];
}

#pragma mark -  LinkedLists

/* TODO crash in dealloc if more than 10000 iterations
- (void)testLinkedListAdd {
    [self performFunctionInBackground:^{
        [self generateLinkedList];
    }];
}

- (void)testLinkedListFastEnumRead {
    YALOptimizedLinkedList *testLinkedList = [self generateLinkedList];

    [self performFunctionInBackground:^{
        for (NSString *str in testLinkedList) {
            NSString *constant = str;
        }
    }];
}*/

- (void)testLinkedListFastEnumDelete {
    YALOptimizedLinkedList *testLinkedList = [self generateLinkedList];

    [self performFunctionInBackground:^{
        for (NSString *item in testLinkedList) {
            [testLinkedList removeFirstOccurenceOf:item];
        }
    }];
}

#pragma mark - Stacks

/* TODO crash in dealloc if more than 10000 iterations
- (void)testStackWriteSpeed {
    [self performFunctionInBackground:^{
        [self generateStack];
    }];
}
 
- (void)testStackReadSpeed {
    YALStack *testStack = [self generateStack];

    [self performFunctionInBackground:^{
        for (int i = 0; i < iterationCount; i++) {
            NSString *constant = [testStack pop];
        }
    }];
} */

#pragma mark - Queues
/* TODO crash in dealloc if more than 10000 iterations
- (void)testQueueWriteSpeed {
   [self performFunctionInBackground:^{
        [self generateQueue];
    }];
}
 
- (void)testQueueReadSpeed {
    YALQueue *testQueue = [self generateQueue];

  [self performFunctionInBackground:^{
        for (int i = 0; i < iterationCount; i++) {
            NSString *constant = [testQueue dequeue];
        }
    }];
} */


#pragma mark - Helper methods

- (NSMutableArray *)generateArray {
    NSMutableArray *testArray = [NSMutableArray new];
    for (NSUInteger i = 0; i < iterationCount; i++) {
        [testArray addObject:[NSString stringWithFormat:@"%@%lu", testString, (unsigned long) i]];
    }

    return testArray;
}

- (NSMutableSet *)generateSet {
    NSMutableSet *testSet = [NSMutableSet new];
    for (NSUInteger i = 0; i < iterationCount; i++) {
        [testSet addObject:[NSString stringWithFormat:@"%@%lu", testString, (unsigned long) i]];
    }

    return testSet;
}

- (NSMutableDictionary *)generateDictionary {
    NSMutableDictionary *testDictionary = [NSMutableDictionary new];
    for (NSUInteger i = 0; i < iterationCount; i++) {
        testDictionary[[NSString stringWithFormat:@"%lu", (unsigned long) i]] = [NSString stringWithFormat:@"%@%lu", testString, (unsigned long) i];
    }

    return testDictionary;
}

- (YALOptimizedLinkedList *)generateLinkedList {
    YALOptimizedLinkedList *testLinkedList = [YALOptimizedLinkedList listWithStartNode:nil];
    for (int i = 0; i < iterationCount; i++) {
        [testLinkedList add:[NSString stringWithFormat:@"%@%d", testString, i]];
    }

    return testLinkedList;
}

- (YALStack *)generateStack {
    YALStack *testStack = [YALStack new];
    for (int i = 0; i < iterationCount; i++) {
        [testStack push:[NSString stringWithFormat:@"%@%d", testString, i]];
    }

    return testStack;
}

- (YALQueue *)generateQueue {
    YALQueue *testQueue = [YALQueue new];
    for (int i = 0; i < iterationCount; i++) {
        [testQueue add:[NSString stringWithFormat:@"%@%d", testString, i]];
    }

    return testQueue;
}


@end
