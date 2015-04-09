//
// Created by Stanislav on 09.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "PerformanceTestCase.h"


@implementation PerformanceTestCase

/*
   This function simulates the performance of the iOS app by making
   sure the test runs on a background thread with identical priority.
   It also uses XCTestExpectation to ensure the test case waits for the
   appropriate length of time for the operation to complete.
   */
- (void)measureInBackgroundForCode: (void(^)())block {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"1"];
        //Use the same queue priority as in the application
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {

            block();
            dispatch_async(dispatch_get_main_queue(), ^() {
                //Now that we're done, fulfill the expectation.
                [expectation fulfill];
            });
        });
        [self waitForExpectationsWithTimeout:5 handler:nil];
    }];
}

//Set a comically long wait time, since some of these take a while,
//especially with optimization off.
- (void)waitForExpectationsWithTimeout:(NSTimeInterval)timeout handler:(XCWaitCompletionHandler)handlerOrNil {
    [super waitForExpectationsWithTimeout:100000000.0 handler:^(NSError *error) {
        
    }];
}

@end