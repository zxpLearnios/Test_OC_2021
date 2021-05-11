//
//  UCMRebateModel.h
//  Pods
//
//  Created by bavaria on 2021/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UCMRebateTradeDateModel;

@interface UCM_rebateModel : NSObject

/// 订单唯一id
@property (nonatomic, strong) NSNumber *orderId;

/// 订单类型,b2c代表商城订单
@property (nonatomic, copy) NSString *orderType;
/// 订单类型 订单名字起那么的icon
@property (nonatomic, copy) NSString *orderTypeIcon;

/// 订单二级类型预留淘客扩展字段
@property (nonatomic, strong) NSNumber *orderTwoType;
/// 订单编号
@property (nonatomic, copy) NSString *orderNo;

/// 商品id
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productNameIcon;
@property (nonatomic, copy) NSString *productIcon;

/// 订单状态
@property (nonatomic, copy) NSString *ordereStatus;
/// 支付金额
@property (nonatomic, copy) NSString *payMoney;
/// 订单收益
@property (nonatomic, copy) NSString *rebateMoney;
/// 佣金类型: 团队奖励
@property (nonatomic, copy) NSString *rebateType;

@property (nonatomic, copy) NSString *userAvator;
@property (nonatomic, copy) NSString *userNickName;
/// 用户等级
@property (nonatomic, copy) NSString *userLevel;
@property (nonatomic, copy) NSString *userLevelIcon;

/// 新加
@property (nonatomic, assign) BOOL isDown;


@property (nonatomic, strong) NSArray <UCMRebateTradeDateModel *> *dateModels;

@end


/// 交易时间
@interface UCMRebateTradeDateModel : NSObject

/// 新加
@property (nonatomic, assign) BOOL isDown;
///   "结算时间:", "收货时间:", "付款时间:"
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *date;

@end

NS_ASSUME_NONNULL_END
