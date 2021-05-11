//
//  UCM_rebateSearchModel.h
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UCM_rebateSearchModel : NSObject

/// 类型 0：我的订单、 1：团队订单
@property (nonatomic, assign) int ucm_type;
/// 关键字
@property (nonatomic, copy) NSString *keyboard;
/// 订单号
@property (nonatomic, copy) NSString *orderId;
/// 比如：2021-01-01
@property (nonatomic, copy) NSString *date;


@end

NS_ASSUME_NONNULL_END
