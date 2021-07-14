//
//  TestContainerBottomCell2.h
//  Test_OC
//
//  Created by bavaria on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestContainerBottomCell2 : UITableViewCell

//@property (nonatomic, assign)  BOOL childCanScroll;
//@property (nonatomic, copy) void (^superCanScrollBlock)(BOOL superCanScroll);

/// 告知外部最高列的高度，方便外部列表及时更新每行高度，适用于存放内部列表的cell.frame完全==最高列的高度
@property (nonatomic, copy) void (^getMaxColumnBlock)(double height);

@end

NS_ASSUME_NONNULL_END
