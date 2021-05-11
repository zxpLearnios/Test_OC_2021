//
//  UCM_rebateSubNewTableView.h
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/4.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>
#import "UCM_rebateSearchModel.h"
#import "UCM_rebateModel.h"

NS_ASSUME_NONNULL_BEGIN


/* 后台：0已付款,1已收货,2已结算,-1已失效,默认为空代表全部订单 */
typedef enum : NSUInteger {
    // 全部
    UCM_rebateSubNewTableViewIndexTypeAll = -2,
    UCM_rebateSubNewTableViewIndexTypeHavePay = 0,
    // 已收货
    UCM_rebateSubNewTableViewIndexTypeHaveGetThing = 1,
    // 已结算
    UCM_rebateSubNewTableViewIndexTypeHaveCloseCal = 2,
    // 已失效
    UCM_rebateSubNewTableViewIndexTypeHaveLoseEfi = -1,
} UCM_rebateSubNewTableViewIndexType;


@protocol UCM_rebateSubNewTableViewDelegate <NSObject>

@optional

/// 获取数据
-(void)getDataWithParams:(NSDictionary *)dic tag:(NSInteger)tag isForLoadMore:(BOOL)isForLoadMore;
/// 点击cell
-(void)tapCellAtIndex:(NSInteger)row model:(UCM_rebateModel *)model;

@end

@interface UCM_rebateSubNewTableView : UITableView <JXCategoryListContentViewDelegate>

@property (nonatomic, strong) UCM_rebateSearchModel *searchModel;
@property (nonatomic, assign) UCM_rebateSubNewTableViewIndexType ucm_index;

@property (nonatomic, weak) id<UCM_rebateSubNewTableViewDelegate> ucm_delegate;

/// 外部调用，防止某些数据在初始化时还没有
-(void)setup;

-(void)beginHeaderRefreshing;
-(void)endHeaderRefreshing;

-(void)beginFootererRefreshing;
-(void)endFootererRefreshing;

#pragma mark 外部请求后，调用之处理外部数据


@end

NS_ASSUME_NONNULL_END
