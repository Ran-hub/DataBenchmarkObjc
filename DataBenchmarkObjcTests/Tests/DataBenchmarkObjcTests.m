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
#import "ArrayHelper.h"
#import "YALRandom.h"
#import "SetHelper.h"
#import "DictionaryHelper.h"

static const NSInteger maxRandomNumber = 100000;

static NSMutableArray *(^generateArrayBlock)(NSInteger);

static NSNumber *(^randomArrayIndexBlock)(NSMutableArray *);

static NSString *(^randomArrayElementBlock)(NSMutableArray *, NSNumber *);

static NSMutableSet *(^generateSetBlock)(NSInteger);

static NSNumber *(^randomSetIndexBlock)(NSMutableSet *);

static NSString *(^randomSetElementBlock)(NSMutableSet *, NSNumber *);

static NSMutableDictionary *(^generateDictionaryBlock)(NSInteger);

static NSString *(^randomDictionaryIndexBlock)(NSMutableDictionary *);

static NSString *(^randomDictionaryElementBlock)(NSMutableDictionary *, NSString *);

NSString *createRandomString();

@interface DataBenchmarkObjcTests : PerformanceTestCase

@end

@implementation DataBenchmarkObjcTests

+ (void)setUp {
    //Array
    generateArrayBlock = ^NSMutableArray *(NSInteger elementCount) {
        return [ArrayHelper generateArray:(NSUInteger) elementCount];
    };

    randomArrayIndexBlock = ^NSNumber *(NSMutableArray *array) {
        return @([ArrayHelper randomArrayIndex:array]);
    };

    randomArrayElementBlock = ^NSString *(NSMutableArray *array, NSNumber *index) {
        return array[[index unsignedIntegerValue]];
    };

    //Set
    generateSetBlock = ^NSMutableSet *(NSInteger elementCount) {
        return [SetHelper generateSet:(NSUInteger) elementCount];
    };

    randomSetIndexBlock = ^NSNumber *(NSMutableSet *set) {
        return @([SetHelper randomSetIndex:set]);
    };

    randomSetElementBlock = ^NSString *(NSMutableSet *set, NSNumber *index) {
        return [SetHelper randomSetElement:set randomIndex:[index unsignedIntegerValue]];
    };

    //Dictionary
    generateDictionaryBlock = ^NSMutableDictionary *(NSInteger elementCount) {
        return [DictionaryHelper generateDictionary:(NSUInteger) elementCount];
    };

    randomDictionaryIndexBlock = ^NSString *(NSMutableDictionary *dictionary) {
        return [DictionaryHelper randomDictionaryIndex:dictionary];
    };

    randomDictionaryElementBlock = ^NSString *(NSMutableDictionary *dictionary, NSString *index) {
        return [DictionaryHelper randomDictionaryElement:dictionary randomIndex:index];
    };
}


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
    [self performTimeTestWithPrepareBlock:generateArrayBlock
                           operationBlock:^(NSMutableArray *array) {
                               [array addObject:createRandomString()];
                           }
                            structureName:@"Array" operationName:@"Add"];
}

- (void)testArrayUpdate {
    [self performTimeTestWithPrepareBlock:generateArrayBlock
                           operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
                               array[[randomIndex unsignedIntegerValue]] = createRandomString();
                           }
                         randomIndexBlock:randomArrayIndexBlock
                       randomElementBlock:randomArrayElementBlock
                            structureName:@"Array" operationName:@"UpdateRandom"];
}

- (void)testArrayByIndexRead {
    [self performTimeTestWithPrepareBlock:generateArrayBlock operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
                NSString *constant = array[[randomIndex unsignedIntegerValue]];
            }            randomIndexBlock:randomArrayIndexBlock
                       randomElementBlock:randomArrayElementBlock
                            structureName:@"Array" operationName:@"ReadRandom"];
}

- (void)testArrayByIndexDelete {
    [self performTimeTestWithPrepareBlock:generateArrayBlock
                           operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
                               [array removeObjectAtIndex:[randomIndex unsignedIntegerValue]];
                           }
                         randomIndexBlock:randomArrayIndexBlock
                       randomElementBlock:randomArrayElementBlock
                            structureName:@"Array" operationName:@"DeleteRandom"];

}

- (void)testArrayContains {
    [self performTimeTestWithPrepareBlock:generateArrayBlock
                           operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
                               BOOL constant = [array containsObject:randomElement];
                           }
                         randomIndexBlock:randomArrayIndexBlock
                       randomElementBlock:randomArrayElementBlock
                            structureName:@"Array" operationName:@"ContainsRandom"];

}

#pragma mark - Sets


- (void)testSetAdd {
    [self performTimeTestWithPrepareBlock:generateSetBlock
                           operationBlock:^(NSMutableSet *set) {
                               [set addObject:createRandomString()];
                           }
                            structureName:@"Set" operationName:@"Add"];
}

- (void)testSetDelete {
    [self performTimeTestWithPrepareBlock:generateSetBlock
                           operationBlock:^(NSMutableSet *set, NSNumber *randomIndex, NSString *randomElement) {
                               [set removeObject:randomElement];
                           }
                         randomIndexBlock:randomSetIndexBlock
                       randomElementBlock:randomSetElementBlock
                            structureName:@"Set" operationName:@"DeleteRandom"];
}

- (void)testSetCheckContain {
    [self performTimeTestWithPrepareBlock:generateSetBlock
                           operationBlock:^(NSMutableSet *set, NSNumber *randomIndex, NSString *randomElement) {
                               BOOL constant = [set containsObject:randomElement];
                           }
                         randomIndexBlock:randomSetIndexBlock
                       randomElementBlock:randomSetElementBlock
                            structureName:@"Set" operationName:@"ContainsRandom"];
}

#pragma mark - Dictionaries

- (void)testDictionaryAdd {
    [self performTimeTestWithPrepareBlock:generateDictionaryBlock
                           operationBlock:^(NSMutableDictionary *dict) {
                               NSString *const uniqueKey = [testString stringByAppendingFormat:@"%d", dict.count];
                               dict[uniqueKey] = createRandomString();
                           }
                            structureName:@"Dictionary" operationName:@"Add"];
}

- (void)testDictionaryUpdate {
    [self performTimeTestWithPrepareBlock:generateDictionaryBlock
                           operationBlock:^(NSMutableDictionary *dictionary, NSNumber *randomIndex, NSString *randomElement) {
                               dictionary[randomIndex] = createRandomString();
                           }
                         randomIndexBlock:randomDictionaryIndexBlock
                       randomElementBlock:randomDictionaryElementBlock
                            structureName:@"Dictionary" operationName:@"UpdateRandom"];
}

- (void)testDictionaryReadByKey {
    [self performTimeTestWithPrepareBlock:generateDictionaryBlock
                           operationBlock:^(NSMutableDictionary *dictionary, NSNumber *randomIndex, NSString *randomElement) {
                               NSString *const constant = dictionary[randomIndex];
                           }
                         randomIndexBlock:randomDictionaryIndexBlock
                       randomElementBlock:randomDictionaryElementBlock
                            structureName:@"Dictionary" operationName:@"ReadRandom"];
}

- (void)testDictionaryDeleteByKey {
    [self performTimeTestWithPrepareBlock:generateDictionaryBlock
                           operationBlock:^(NSMutableDictionary *dictionary, NSString *randomIndex, NSString *randomElement) {
                               [dictionary removeObjectForKey:randomIndex];
                           }
                         randomIndexBlock:randomDictionaryIndexBlock
                       randomElementBlock:randomDictionaryElementBlock
                            structureName:@"Dictionary" operationName:@"DeleteRandom"];
}

- (void)testDictionaryCheckContain {
    [self performTimeTestWithPrepareBlock:generateDictionaryBlock
                           operationBlock:^(NSMutableDictionary *dictionary, NSString *randomIndex, NSString *randomElement) {
                               [dictionary.allValues containsObject:randomElement];
                           }
                         randomIndexBlock:randomDictionaryIndexBlock
                       randomElementBlock:randomDictionaryElementBlock
                            structureName:@"Dictionary" operationName:@"ContainsRandom"];
}

NSString *createRandomString() {
    return [NSString stringWithFormat:@"%@%d", testString, [YALRandom intFrom:0 to:maxRandomNumber]];
}


@end
