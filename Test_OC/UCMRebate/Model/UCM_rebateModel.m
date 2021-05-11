//
//  UCMRebateModel.m
//  Pods
//
//  Created by bavaria on 2021/2/2.
//

#import "UCM_rebateModel.h"

@implementation UCM_rebateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{ @"orderId": @"id",
             @"orderType": @"model",
             @"orderTwoType": @"type",
             @"orderNo": @"trade_id",
             
             @"productId": @"product_id",
             @"productName": @"goods_name",
             @"productIcon": @"goods_img",
             @"productNameIcon": @"icon",
             
             @"ordereStatus": @"order_status",
             @"payMoney": @"pay_price",
             
             @"rebateMoney": @"rebate",
             
             @"userAvator": @"avatar",
             @"userNickName": @"nickname",
             @"userLevel": @"level_namer",
             @"userLevelIcon": @"level_icon",
             @"rebateType": @"types",
             @"dateModels": @"time"
             
    };
}


/// 前边，是属性数组的名字，后边就是类名
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dateModels" : @"UCMRebateTradeDateModel"};
}

@end




@implementation UCMRebateTradeDateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{ @"name": @"name",
             @"date": @"time",
    };
}






@end
