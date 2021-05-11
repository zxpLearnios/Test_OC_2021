//
//  CLTestSharedViewManager.m
//  Test_OC
//
//  Created by bavaria on 2021/1/26.
//

#import "CLTestSharedViewManager.h"

@interface CLTestSharedViewManager ()
@end

@implementation CLTestSharedViewManager

+(instancetype)shared {
    static CLTestSharedViewManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[CLTestSharedViewManager alloc] init];
    });
    return obj;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.view = [[CLTestSharedView alloc]init];
}

@end
