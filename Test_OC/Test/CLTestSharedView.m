//
//  CLTestSharedView.m
//  CLSETC
//
//  Created by bavaria on 2021/1/26.
//  Copyright © 2021 cls. All rights reserved.
//  单利view是无法释放的，即使设置nil也无用

#import "CLTestSharedView.h"

@implementation CLTestSharedView

+ (instancetype)shared {
    static CLTestSharedView *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[CLTestSharedView alloc] init];
    });
    return obj;
}

- (void)dealloc
{
    NSLog(@"CLTestSharedView--deinit");
}

@end
