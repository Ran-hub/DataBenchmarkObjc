//
// Created by Stanislav on 09.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "PerformanceTestCase.h"
#import <QuartzCore/QuartzCore.h>
#import "CHCSVParser.h"

@implementation PerformanceTestCase


- (void)performTimeTestWithPrepareBlock:(id(^)(NSInteger count))prepareBlock operationBlock:(NSTimeInterval (^)(id))operationBlock structureName:(NSString *)structureName operationName:(NSString *)operationName {
    NSMutableArray *attemptsWithSumTime = [NSMutableArray arrayWithCapacity:maxElementsInStructure];
    for (NSUInteger i = 0; i < maxElementsInStructure; i++) {
        attemptsWithSumTime[i] = @0;
    }

    for (int attempt = 0; attempt < attemptsCount; attempt++) {
        for (NSUInteger elementCount = 0; elementCount < maxElementsInStructure; elementCount++) {
            id structure = prepareBlock(elementCount);
            NSTimeInterval time = operationBlock(structure);
            attemptsWithSumTime[elementCount] = @([attemptsWithSumTime[elementCount] doubleValue] + time);
        }
    }

    [self writeToCSV:structureName operationName:operationName attemptsWithSumTime:attemptsWithSumTime];
}

- (void)performTimeTestWithPrepareBlock:(id(^)(NSInteger count))prepareBlock
                         operationBlock:(NSTimeInterval (^)(id, id, id))operationBlock
                       randomIndexBlock:(id(^)(id))randomIndexBlock
                     randomElementBlock:(id(^)(id, id))randomElementBlock
                          structureName:(NSString *)structureName
                          operationName:(NSString *)operationName {
    NSMutableArray *attemptsWithSumTime = [[NSMutableArray alloc] initWithCapacity:maxElementsInStructure];
    for (NSUInteger i = 0; i < maxElementsInStructure; i++) {
        attemptsWithSumTime[i] = @0;
    }

    for (int attempt = 0; attempt < attemptsCount; attempt++) {
        for (NSUInteger elementCount = 1; elementCount < maxElementsInStructure; elementCount++) {
            id structure = prepareBlock(elementCount);
            id randomIndex = randomIndexBlock(structure);
            id randomElement = randomElementBlock(structure, randomIndex);

            NSTimeInterval time = operationBlock(structure, randomIndex, randomElement);
            attemptsWithSumTime[elementCount] = @([attemptsWithSumTime[elementCount] doubleValue] + time);
        }
    }

    [self writeToCSV:structureName operationName:operationName attemptsWithSumTime:attemptsWithSumTime];
}

- (void)writeToCSV:(NSString *)structureName operationName:(NSString *)operationName attemptsWithSumTime:(NSMutableArray *)attemptsWithSumTime {
    NSString *fileName = [NSString stringWithFormat:@"%@-%@.csv", structureName, operationName];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
    NSOutputStream *output = [NSOutputStream outputStreamToMemory];
    unichar delimiter = 44;
    CHCSVWriter *writer = [[CHCSVWriter alloc] initWithOutputStream:output encoding:NSUTF8StringEncoding delimiter:delimiter];
    [writer writeField:@"Objective-C"];
    [writer writeField:@""];
    [writer finishLine];
    for (NSUInteger elementCount = 0; elementCount < maxElementsInStructure; elementCount++) {
        NSTimeInterval average = [attemptsWithSumTime[elementCount] doubleValue] / attemptsCount;
        [writer writeField:@(average)];
        [writer writeField:@(elementCount)];
        [writer finishLine];
    }
    [writer closeStream];

    NSData *buffer = [output propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    NSString *csv = [[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding];
    [csv writeToFile:path atomically:FALSE encoding:NSUTF8StringEncoding error:nil];
}

@end