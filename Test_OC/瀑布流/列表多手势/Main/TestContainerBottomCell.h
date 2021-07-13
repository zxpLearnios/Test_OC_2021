//
//  TestContainerBottomCell.h
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestContainerBottomCell : UITableViewCell
@property (nonatomic, assign)  BOOL childCanScroll;
@property (nonatomic, copy) void (^superCanScrollBlock)(BOOL superCanScroll);
@end

NS_ASSUME_NONNULL_END
