//
//  ComplexDataTests.m
//  DataBenchmarkObjc
//
//  Created by Stas Kirichok on 10.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PerformanceTestCase.h"
#import "YALLinkedList.h"
#import "YALOptimizedLinkedList.h"
#import "YALStack.h"
#import "YALQueue.h"

static const NSInteger iterationCount = 10000;

@interface ComplexDataTests : PerformanceTestCase

@end

@implementation ComplexDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// TODO need to fix crash in dealloc if more than 10000 iteration

#pragma mark -  LinkedLists

- (void)testLinkedListAdd {
    [self measureInBackgroundForCode:^{
        [self generateLinkedList];
    }];
}

- (void)testLinkedListFastEnumRead {
    YALOptimizedLinkedList *testLinkedList = [self generateLinkedList];
    
    [self measureInBackgroundForCode:^{
        for (NSString *str in testLinkedList) {
            NSString *constant = str;
        }
    }];
}

- (void)testLinkedListFastEnumDelete {
    YALOptimizedLinkedList *testLinkedList = [self generateLinkedList];
    
    [self measureInBackgroundForCode:^{
        for (NSString *item in testLinkedList) {
            [testLinkedList removeFirstOccurenceOf:item];
        }
    }];
}

#pragma mark - Stacks

- (void)testStackWriteSpeed {
    [self measureInBackgroundForCode:^{
        [self generateStack];
    }];
}

- (void)testStackReadSpeed {
    YALStack *testStack = [self generateStack];
    
    [self measureInBackgroundForCode:^{
        for (int i = 0; i < iterationCount; i++) {
            NSString *constant = [testStack pop];
        }
    }];
}

#pragma mark - Queues

- (void)testQueueWriteSpeed {
    [self measureInBackgroundForCode:^{
        [self generateQueue];
    }];
}

- (void)testQueueReadSpeed {
    YALQueue *testQueue = [self generateQueue];
    
    [self measureInBackgroundForCode:^{
        for (int i = 0; i < iterationCount; i++) {
            NSString *constant = [testQueue dequeue];
        }
    }];
}

#pragma mark - Helper methods

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
