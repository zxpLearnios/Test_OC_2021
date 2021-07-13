//
//  TestGestureTableView.m
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//  允许多手势的列表 一般用于父列表; scrollview 默认会阻止手势的传递，即不回触发控制器的view的touchesBegan，故需要回调给外部

#import "TestGestureTableView.h"

@interface TestGestureTableView() <UIGestureRecognizerDelegate>

@end

@implementation TestGestureTableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark 注释 看是否需要，因为有此法会导致collectionview的didSelectItem无法触发
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (self.touchBeganBlock) {
//        self.touchBeganBlock(touches, event);
//    }
//}

@end
