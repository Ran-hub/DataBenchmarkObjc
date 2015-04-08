//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "DataStorage.h"


@implementation DataStorage

- (NSComparisonResult)compare:(DataStorage *)object {
    if (![self.key respondsToSelector:@selector(compare:)]) {
        [NSException raise:@"Invalid key type" format:@"Compare isn't supported"];
    }
    return [self.key compare:object.key];
}

@end