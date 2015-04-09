//
//  DataBenchmarkObjcTests.m
//  DataBenchmarkObjcTests
//
//  Created by Stanislav on 02.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PerformanceTestCase.h"
#import "YALRandom.h"

static const NSInteger iterationCount = 1000000;


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
  [self measureInBackgroundForCode:^{
      [self generateArray];
  }];
}

- (void)testArrayUpdate {
    NSMutableArray *testArray = [self generateArray];
     [self measureInBackgroundForCode:^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            NSInteger randomInt = [YALRandom intFrom:0 to:iterationCount];
            testArray[i] = [NSString stringWithFormat:@"%@%u", testString, randomInt];
        }
    }];
}

- (void)testArrayReadFastEnum {
    NSMutableArray *testArray = [self generateArray];

     [self measureInBackgroundForCode:^{
        for (NSString *str in testArray) {
            NSString *const constant = str;
        }
    }];
}

- (void)testArrayReadByIndex {
    NSMutableArray *testArray = [self generateArray];

     [self measureInBackgroundForCode:^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            NSString *const constant = testArray[i];
        }
    }];
}

- (void)testArrayDeleteByIndex {
    NSMutableArray *testArray = [self generateArray];

     [self measureInBackgroundForCode:^{
        for (NSUInteger i = 0; i < testArray.count; i++) {
            [testArray removeObjectAtIndex:i];
        }
    }];
}

- (void)testArrayFindByIndex {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
     [self measureInBackgroundForCode:^{
        [testArray indexOfObject:last];
    }];
}

- (void)testArrayCheckContain {
    NSMutableArray *testArray = [self generateArray];
    NSString *const last = testArray.lastObject;
     [self measureInBackgroundForCode:^{
        [testArray containsObject:last];
    }];
}


#pragma mark - Sets

- (void)testSetAdd {
      [self measureInBackgroundForCode:^{
        [self generateSet];
    }];
}

- (void)testSetFastEnumRead {
    NSMutableSet *testSet = [self generateSet];

     [self measureInBackgroundForCode:^{
        for (NSString *str in testSet) {
            NSString *const constant = str;
        }
    }];
}

- (void)testSetDelete {
    NSMutableSet *testSet = [self generateSet];
    NSMutableSet *removeSet = [NSMutableSet new];
      [self measureInBackgroundForCode:^{
          for (NSString *item in testSet) {
            [removeSet addObject:item];
        }
        [testSet minusSet:removeSet];
    }];
}

- (void)testSetCheckContain {
    NSMutableSet *testSet = [self generateSet];

    NSString *const toFound = [NSString stringWithFormat:@"%@%u", testString, iterationCount - 1];
     [self measureInBackgroundForCode:^{
        [testSet containsObject:toFound];
    }];
}

#pragma mark - Dictionaries

- (void)testDictionaryAdd {
     [self measureInBackgroundForCode:^{
        [self generateDictionary];
    }];
}

- (void)testDictionaryUpdate {
    NSMutableDictionary *testDictionary = [self generateDictionary];
    NSMutableDictionary *randomDictionary = [[NSMutableDictionary alloc] initWithCapacity:testDictionary.count];
    for (NSInteger i = 0; i < iterationCount; i++) {
        randomDictionary[[NSString stringWithFormat:@"%d", i]] = [NSString stringWithFormat:@"%@%u", testString, [YALRandom intFrom:0 to:iterationCount]];
    }
     [self measureInBackgroundForCode:^{
        for (NSString *key in testDictionary.allKeys) {
            testDictionary[key] = randomDictionary[key];
        }
    }];
}

- (void)testDictionaryReadFastEnum {
    NSMutableDictionary *testDictionary = [self generateDictionary];

      [self measureInBackgroundForCode:^{
        for (NSString *value in testDictionary.allValues) {
            NSString *const constant = value;
        }
    }];
}

- (void)testDictionaryReadByKey {
    NSMutableDictionary *testDictionary = [self generateDictionary];

      [self measureInBackgroundForCode:^{
        for (NSUInteger i = 0; i < testDictionary.count; i++) {
            NSString *const constant = testDictionary[[NSString stringWithFormat:@"%lu", (unsigned long) i]];
        }
    }];
}

- (void)testDictionaryDeleteByKey {
    NSMutableDictionary *testDictionary = [self generateDictionary];

     [self measureInBackgroundForCode:^{
        for (NSUInteger i = 0; i < testDictionary.count; i++) {
            [testDictionary removeObjectForKey:[NSString stringWithFormat:@"%lu", (unsigned long) i]];
        }
    }];
}

- (void)testDictionaryCheckContain {
    NSMutableDictionary *testDictionary = [self generateDictionary];

    NSString *const toFound = [NSString stringWithFormat:@"%@%u", testString, iterationCount - 1];
     [self measureInBackgroundForCode:^{
        [testDictionary.allValues containsObject:toFound];
    }];
}

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


@end
