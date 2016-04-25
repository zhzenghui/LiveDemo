//
//  UserSpec.m
//  LiveGaming
//
//  Created by xy on 16/3/1.
//  Copyright 2016年 zenghui. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "User.h"


SPEC_BEGIN(UserSpec)

    describe(@"User", ^{
        it(@"is pretty cool", ^{
            NSUInteger a = 16;
            NSUInteger b = 26;
            [[theValue(a + b) should] equal:theValue(42)];
        });
    });

    describe(@"SimpleString", ^{
        context(@"when assigned to 'Hello world'", ^{
            NSString *greeting = @"Hello world";
            it(@"should exist", ^{
                [[greeting shouldNot] beNil];
            });
            
            it(@"should equal to 'Hello world'", ^{
                [[greeting should] equal:@"Hello world"];
            });
        });
    });


    __block User *stack = nil;
    beforeEach(^{
        stack = [User new];
    });

    afterEach(^{
        stack = nil;
    });

    it(@"should have the class VVStack", ^{
        [[[User class] shouldNot] beNil];
    });

    it(@"should exist", ^{
        [[stack shouldNot] beNil];
    });

    it(@"should be able to push and get top", ^{
//        [User push:2.3];
//        [[theValue([stack top]) should] equal:theValue(2.3)];
//        
//        [User push:4.6];
//        [[theValue([stack top]) should] equal:4.6 withDelta:0.001];
    });

SPEC_END
