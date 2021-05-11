//
//  UCM_rebateNewSubViewController.h
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/4.
//


#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerView.h>
#import <JXPagingView/JXPagerListRefreshView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "UCM_rebateSearchModel.h"




@interface UCM_rebateNewSubViewController : UIViewController <JXCategoryViewDelegate, JXPagerViewListViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, assign, readonly) int currentIndex;
@property (nonatomic, assign, readonly) int totalPage;

// 0: 我的订单  1：团队订单
//@property (nonatomic, assign) int ucm_type;
@property (nonatomic, strong) UCM_rebateSearchModel *searchModel;
@property (nonatomic, strong) UIScrollView *contentScrollView;

-(void)reloadData;
@end
