//
//  TestGestureTableView.h
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestGestureTableView : UITableView

@property (nonatomic, copy) void (^touchBeganBlock)(NSSet<UITouch *> *touches, UIEvent *event);

@end

NS_ASSUME_NONNULL_END
