//
//  Node.h
//  DataBenchmarkObjc
//
//  Created by Stanislav on 06.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YALNode : NSObject

@property (nonatomic, strong) id storedValue;

- (instancetype)initWithStoredValue:(id)value;

+ (instancetype)nodeWithStoredValue:(id)value;

@end
