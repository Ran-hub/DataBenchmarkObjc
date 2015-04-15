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

static const NSInteger iterationCount = 1000000;


@interface DataBenchmarkObjcTests : PerformanceTestCase

@property (nonatomic, copy) id (^generateArrayBlock)(NSInteger );
@property (nonatomic, copy) NSNumber * (^randomArrayIndexBlock)(NSMutableArray *);
@property (nonatomic, copy) NSString * (^randomArrayElementBlock)(NSMutableArray *, NSNumber *);

@end

@implementation DataBenchmarkObjcTests

- (instancetype)init {
    self = [super init];
    if (self) {
        self.generateArrayBlock = ^NSMutableArray *(NSInteger elementCount) {
            return [ArrayHelper generateArray:(NSUInteger) elementCount];
        };

        self.randomArrayIndexBlock = ^NSNumber *(NSMutableArray * array) {
            return @([ArrayHelper randomArrayIndex:array]);
        };

        self.randomArrayElementBlock = ^NSString *(NSMutableArray * array, NSNumber *index) {
            return array[[index unsignedIntegerValue]];
        };
    }

    return self;
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
    [self performTimeTestWithPrepareBlock:self.generateArrayBlock
                           operationBlock:^(NSMutableArray *array) {
                               [array addObject:[NSString stringWithFormat:@"%@%d", testString, [YALRandom intFrom:0 to:iterationCount]]];
                           } structureName:@"Array" operationName:@"Add"];
}

- (void)testArrayUpdate {
    [self performTimeTestWithPrepareBlock:self.generateArrayBlock
                           operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
                               if (array.count == 0) {
                                   return;
                               }
                               array[[randomIndex unsignedIntegerValue]] = [NSString stringWithFormat:@"%@%d", testString, [YALRandom intFrom:0 to:iterationCount]];
                           }
                         randomIndexBlock:self.randomArrayIndexBlock
                       randomElementBlock:self.randomArrayElementBlock
                            structureName:@"Array" operationName:@"UpdateRandom"];
}

- (void)testArrayByIndexRead {
    [self performTimeTestWithPrepareBlock:self.generateArrayBlock operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
                if (array.count == 0) {
                    return;
                }
                NSString *constant = array[[randomIndex unsignedIntegerValue]];
            }            randomIndexBlock:self.randomArrayIndexBlock
                       randomElementBlock:self.randomArrayElementBlock
                            structureName:@"Array" operationName:@"ReadRandom"];
}

-(void)testArrayByIndexDelete {
    [self performTimeTestWithPrepareBlock:self.generateArrayBlock
                           operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
        if (array.count == 0) {
            return;
        }
        [array removeAtIndex: randomIndex] ];
    }, randomIndexBlock: ArrayHelper.randomArrayIndex, randomElementBlock: ArrayHelper.randomArrayElement, structureName: "Array", operationName: "DeleteRandom")

}

-(void)testArrayContains {
    [self performTimeTestWithPrepareBlock:self.generateArrayBlock
                           operationBlock:^(NSMutableArray *array, NSNumber *randomIndex, NSString *randomElement) {
        if (array.count == 0) {
            return
        }
        let constant = contains(array, randomElement!)
    }, randomIndexBlock: ArrayHelper.randomArrayIndex, randomElementBlock: ArrayHelper.randomArrayElement, structureName: "Array", operationName: "ContainsRandom")

}

#pragma mark - Sets


-(void)testSetAdd {
    self.performTimeTest(SetHelper.generateSet, operationBlock: { (var set: Set<String>) -> () in
        set.insert(testString + String(Random.rndInt(0, to: iterationCount)))
    }, structureName: "Set", operationName: "Add")
}

-(void)testSetDelete {
    self.performTimeTest(SetHelper.generateSet, operationBlock: {
        (var set: Set<String>, randomIndex: Int?, randomElement: String?) -> () in
        if (set.count == 0) {
            return
        }
        set.remove(randomElement!)
    }, randomIndexBlock: SetHelper.randomSetIndex, randomElementBlock: SetHelper.randomSetElement, structureName: "Set", operationName: "DeleteRandom")
}

-(void)testSetCheckContain {
    self.performTimeTest(SetHelper.generateSet, operationBlock: {
        (var set: Set<String>, randomIndex: Int?, randomElement: String?) -> () in
        if (set.count == 0) {
            return
        }
        let constant = contains(set, randomElement!)
    }, randomIndexBlock: SetHelper.randomSetIndex, randomElementBlock: SetHelper.randomSetElement, structureName: "Set", operationName: "ContainsRandom")
}}

#pragma mark - Dictionaries

-(void)testDictionaryAdd {
    self.performTimeTest(DictionaryHelper.generateDictionary, operationBlock: { (var dict: [String: String]) -> () in
        let uniqueKey = testString + String(dict.count)
        dict[uniqueKey] = (testString + String(Random.rndInt(0, to: iterationCount)))
    }, structureName: "Dictionary", operationName: "Add")
}

-(void)testDictionaryUpdate {
    self.performTimeTest(DictionaryHelper.generateDictionary, operationBlock: {
        (var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
        if (dictionary.count == 0) {
            return
        }
        dictionary[randomIndex!] = (testString + String(Random.rndInt(0, to: iterationCount)))
    }, randomIndexBlock: DictionaryHelper.randomDictionaryIndex, randomElementBlock: DictionaryHelper.randomDictionaryElement, structureName: "Dictionary", operationName: "UpdateRandom")
}

-(void)testDictionaryReadByKey {
    self.performTimeTest(DictionaryHelper.generateDictionary, operationBlock: {
        (var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
        if (dictionary.count == 0) {
            return
        }
        let constant = dictionary[randomIndex!]
    }, randomIndexBlock: DictionaryHelper.randomDictionaryIndex, randomElementBlock: DictionaryHelper.randomDictionaryElement, structureName: "Dictionary", operationName: "ReadRandom")
}

-(void)testDictionaryDeleteByKey {
    self.performTimeTest(DictionaryHelper.generateDictionary, operationBlock: {
        (var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
        if (dictionary.count == 0) {
            return
        }
        dictionary.removeValueForKey(randomIndex!)
    }, randomIndexBlock: DictionaryHelper.randomDictionaryIndex, randomElementBlock: DictionaryHelper.randomDictionaryElement, structureName: "Dictionary", operationName: "DeleteRandom")
}

-(void)testDictionaryCheckContain {
    self.performTimeTest(DictionaryHelper.generateDictionary, operationBlock: {
        (var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
        if (dictionary.count == 0) {
            return
        }
        contains(dictionary.values, randomElement!)
    }, randomIndexBlock: DictionaryHelper.randomDictionaryIndex, randomElementBlock: DictionaryHelper.randomDictionaryElement, structureName: "Dictionary", operationName: "ContainsRandom")
}



@end
