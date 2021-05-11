//
//  UCMRebateViewController.h
//  AFNetworking
//
//  Created by bavaria on 2021/2/2.
//  返佣订单

#import <UIKit/UIKit.h>
#import "UCM_rebateSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UCM_rebateViewController : UIViewController

/// 选择日期，输入关键字后会 赋值相应的属性. 外部会初始化之则可以设置，其余的可以回调过来，即不直接设置之
@property (nonatomic, strong) UCM_rebateSearchModel *searchModel;

@end

NS_ASSUME_NONNULL_END
