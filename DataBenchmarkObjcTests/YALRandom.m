//
// Created by Stanislav on 09.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALRandom.h"


@implementation YALRandom

+ (int)intFrom: (int)from to: (int)to {
    return (arc4random_uniform((u_int32_t) (to - from + 1)) + from);
}

+ (double)doubleFrom: (double)from to: (double)to {
    return drand48() * (to - from) + from;
}

+ (BOOL)boolValue {
    return (BOOL) [self intFrom: 0 to: 1];
}

+ (BOOL)boolValueWithProbability: (double)prob {
    return [self doubleFrom: 0 to: 1] <= prob;
}

+ (id)oneFrom: (NSArray *)array {
    return array[(NSUInteger) [self intFrom: 0 to: array.count - 1]];
}

@end