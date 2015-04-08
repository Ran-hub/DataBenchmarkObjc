//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YALLinkedList.h"


@interface YALOptimizedLinkedList : YALLinkedList

- (id)last;

- (void)add:(id)value;

- (BOOL)removeFirstOccurenceOf:(id)value;
@end