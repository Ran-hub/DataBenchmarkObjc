//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataStorage : NSObject

@property (nonatomic, strong) id key;
@property (nonatomic, strong) id value;


//No built-in comparison protocol
- (NSComparisonResult)compare:(DataStorage *)object;

@end