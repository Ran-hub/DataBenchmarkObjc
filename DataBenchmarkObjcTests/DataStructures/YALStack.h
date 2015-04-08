//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YALLinkedList.h"


@interface YALStack : YALLinkedList
- (void)push:(id)value;

- (id)pop;
@end