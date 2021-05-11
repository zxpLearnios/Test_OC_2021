//
//  UCMRebateViewController.m
//  AFNetworking
//
//  Created by bavaria on 2021/2/2.
//  不支持子控制器里装很多子控制器时的滑动

#import "UCM_rebateViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <JXPagingView/JXPagerListRefreshView.h>
#import <JXCategoryView/JXCategoryView.h>

#import "UCM_rebateNewSubViewController.h"
#import "UCM_rebateSearchModel.h"

@interface UCM_rebateViewController () <JXCategoryViewDelegate, JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *categoryTitleView;
@property (nonatomic, strong) JXPagerListRefreshView *pageView;

/// 当前类型 0: 我的订单  1：团队订单
@property (nonatomic, assign) int currentType;
@property (nonatomic, strong) NSDate *myOrderSelectDate;
/// 年月日 2020-01-10
@property (nonatomic, copy) NSString *myOrderSelectValue;

@property (nonatomic, strong) NSDate *teamOrderSelectDate;
@property (nonatomic, copy) NSString *teamOrderSelectValue;

@end

@implementation UCM_rebateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"我的订单", @"团队订单"];
    
    if (!self.searchModel) { // 无外部传过来的值
        self.searchModel = [[UCM_rebateSearchModel alloc]init];
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.searchModel.ucm_type == 0);
    [self setupPageView];
    [self setupNavigationItem];
}

-(void)setupPageView {
    JXCategoryTitleView *categoryTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    self.categoryTitleView = categoryTitleView;
    
    categoryTitleView.titles = self.titles;
    categoryTitleView.delegate = self;
    categoryTitleView.titleSelectedColor = [UIColor redColor];
    categoryTitleView.titleColor = [UIColor blackColor];
    categoryTitleView.titleColorGradientEnabled = YES;
    categoryTitleView.titleFont = [UIFont systemFontOfSize:15];
    categoryTitleView.titleSelectedFont = [UIFont systemFontOfSize:15];
    if (!self.searchModel || self.searchModel.ucm_type <= 0) {
        categoryTitleView.defaultSelectedIndex = 0;
    } else {
        categoryTitleView.defaultSelectedIndex = self.searchModel.ucm_type;
    }
    
    JXPagerListRefreshView *pageView = [[JXPagerListRefreshView alloc] initWithDelegate:self];
    self.pageView = pageView;
//    pageView.mainTableView.scrollEnabled = NO;
    pageView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pageView];

    categoryTitleView.listContainer = (id<JXCategoryViewListContainer>)pageView.listContainerView;
    
    self.contentScrollView = pageView.listContainerView.scrollView;
}

-(void)setupNavigationItem {
    self.navigationItem.titleView = self.categoryTitleView;
    
    // 这样设置会导致titleView显示不出来
//    QMUIButton *queryDateBtn = [[QMUIButton alloc]init];
//
//    UIImage *img = ucm_imageName(@"ucm_centerModule_queryDate", @"UCMCenterModule", nil);;
//    queryDateBtn.frame = CGRectMake(0, 0, 17, 16);
//    [queryDateBtn setBackgroundImage:img forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:queryDateBtn];
//
//    @weakify(self);
//    queryDateBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
//        [self navigationItemAction:0];
//    };
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 控制显示区域，即列表区域
    CGFloat w = self.pageView.frame.size.width;
    CGFloat h = self.pageView.frame.size.height;
    
    if (w != self.view.frame.size.width || h != self.view.frame.size.height - 88) {
        self.pageView.frame = CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88);
    }
}





#pragma mark navigationitem
-(void)navigationItemAction:(int)tag {
    if (tag == 0) { // 日期
        
    }
}

#pragma mark --------------- set ------------------
-(void)setSearchModel:(UCM_rebateSearchModel *)searchModel {
    _searchModel = searchModel;
    [self.pageView reloadData];
}

#pragma mark - JXPagerViewDelegate  view 必须 != nil

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    UIView *view = [[UIView alloc]init];
    return view;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 0;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 0;
}


- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    UIView *view = [[UIView alloc]init];
    return view;
}

/// 先调, 由于方法先后调用的问题，所以在此法里也赋值下currentType.
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    // 每次都新创建，即每次搜索后都会进入‘全部’那栏  方式一 二，
    UCM_rebateNewSubViewController *subVc = [[UCM_rebateNewSubViewController alloc] init]; // UCM_rebateSubViewController  UCM_rebateNewSubViewController
    
    UCM_rebateSearchModel *searchModel = self.searchModel;
    
    // 类型  0: 我的订单  1：团队订单
    self.currentType = index;
    
    self.searchModel.ucm_type = index;
    if (self.currentType == 0) {
        self.searchModel.date = self.myOrderSelectValue;
    } else {
        self.searchModel.date = self.teamOrderSelectValue;
    }
    
    subVc.searchModel = searchModel;
    return subVc;
}



#pragma mark - JXCategoryViewDelegate

///  点击选中或者滚动选中都会调用该方法。后调
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.currentType = index;
    // 切换子控制器时，点击搜索
    self.searchModel.ucm_type = index;
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"点击了最外层父vc 的 %d", index);
}




#pragma mark - JXPagerMainTableViewGestureDelegate
//
//- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
////
////    UIScrollView *gesScroller = (UIScrollView *)gestureRecognizer.view;
////    UIScrollView *otScroller = (UIScrollView *)otherGestureRecognizer.view;
////
////    // gestureRecognizer 作用于最外层， otherGestureRecognizer作用于当前层的scroller
////    if (gestureRecognizer.state == UIGestureRecognizerStatePossible &&  otherGestureRecognizer.state == UIGestureRecognizerStateBegan) { // 手向右滚动即第一页 或者 手向左滚动即左后一页
////
////        NSArray *suVcAry = self.pageView.validListDict.allValues;
////        if (self.currentType == 0) { // 我的订单
////            if (suVcAry.count >= 1) {
////                UCM_rebateSubViewController *curentSubVc = suVcAry[0];
////                if (curentSubVc.currentIndex == curentSubVc.totalPage - 1) { // 最后一个控制器
////                    return YES;
////                } else {
////                    return NO;
////                }
////            } else {
////                return NO;
////            }
////        } else if (self.currentType == 1) {
////            if (suVcAry.count >= 2) {
////                UCM_rebateSubViewController *curentSubVc = suVcAry[1];
////                if (curentSubVc.currentIndex == curentSubVc.totalPage - 1) { // 最后一个控制器
////                    return YES;
////                } else {
////                    return NO;
////                }
////            } else {
////                return NO;
////            }
////        }
////
////    }
//
//    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
//}
//
//- (BOOL)checkIsNestContentScrollView:(UIScrollView *)scrollView {
//    for (UCM_rebateNewSubViewController *subVc in self.pageView.validListDict.allValues) {
//        if (subVc.contentScrollView == scrollView) {
//            return YES;
//        }
//    }
//    return NO;
//}


@end



