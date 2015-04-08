//
//  YALLinkedList.h
//  DataBenchmarkObjc
//
//  Created by Stanislav on 06.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YALLinkedNode;

@interface YALLinkedList : NSObject<NSFastEnumeration>

@property(nonatomic, strong) YALLinkedNode *startNode;

- (instancetype)initWithStartNode:(YALLinkedNode *)startNode;

+ (instancetype)listWithStartNode:(YALLinkedNode *)startNode;


@end
