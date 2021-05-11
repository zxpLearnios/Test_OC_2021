//
//  UCM_rebateNewSubViewController.m
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/4.
//  方式二，一级, 里面放二级view 新的, 一二级都可以滑动. 设置endRefreshWithNodata无问题，但是UCMBase里的基列表就偶遇问题

#import "UCM_rebateNewSubViewController.h"

#import "UCM_rebateSubNewTableView.h"

#import <Masonry/Masonry.h>

@interface UCM_rebateNewSubViewController () <UCM_rebateSubNewTableViewDelegate>
@property (nonatomic, assign) int s_currentIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIScrollView *currentListView;


@property (nonatomic, strong) JXCategoryTitleView *categoryTitleView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;



///----- 解决tableview 作为collectionview的item时的重用问题
@property (nonatomic, strong) NSMutableArray <UCM_rebateSubNewTableView *> *listViewAry;

/// 当前请求的列表 tag: 是否需要benginrefresh ,只有首次加载才需要
@property (nonatomic, strong) NSMutableDictionary *currentRequestListDic;
/// 是否是外部调用了刷新
@property (nonatomic, assign) BOOL isReloadDataByOutside;

@end

@implementation UCM_rebateNewSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // @"全部", @"已付款", @"已收货", @"已结算", @"已失效"
    self.titles = @[@"全部", @"已付款", @"已收货", @"已结算", @"已失效"];
    
    
    
    if (!self.searchModel) { // 无外部传过来的值
        self.searchModel = [[UCM_rebateSearchModel alloc]init];
    }
    
    // titleview
    [self setupPageView];
    
    // search
    [self setupSearchAndLayout];

    // list
    self.currentRequestListDic = [NSMutableDictionary dictionary];
    
    self.listViewAry = [NSMutableArray array];
    
    for (int i=0; i<self.titles.count; i++) {
        UCM_rebateSubNewTableView *listview = [[UCM_rebateSubNewTableView alloc]init];
        listview.delegate = self;
        listview.tag = i;
        [self.listViewAry addObject:listview];
        
        // 3.
        NSString *key = [NSString stringWithFormat:@"%d", i];
        self.currentRequestListDic[key] = @(1);
    }
}


-(void)setupPageView {
    JXCategoryTitleView *categoryTitleView = [[JXCategoryTitleView alloc] init];
    self.categoryTitleView = categoryTitleView;
    
    categoryTitleView.titles = self.titles;
    categoryTitleView.delegate = self;
    categoryTitleView.titleSelectedColor = [UIColor redColor];
//    categoryTitleView.titleColor = UCM_333333_Color;
    categoryTitleView.titleColorGradientEnabled = YES;
    categoryTitleView.titleFont = [UIFont systemFontOfSize:15];
    categoryTitleView.titleSelectedFont = [UIFont systemFontOfSize:15];
    
// FIXME: 由于内部容易是collectionView,所以单个列表view会重用的，故需要外部赋datasource
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    self.listContainerView = listContainerView;
    
    [self.view addSubview:listContainerView];
    
    categoryTitleView.listContainer = listContainerView;
    self.contentScrollView = listContainerView.scrollView;
}

-(void)setupSearchAndLayout {
    // container
    UIView *header = [[UIView alloc]init];
    
    UIView *searchView = [[UIView alloc]init];
    UIView *searchContainer = [[UIView alloc]init];
    UIButton *searchCoverBtn = [[UIButton alloc]init];
    UIImageView *searchIcon = [[UIImageView alloc]init];
    UILabel *searchLab = [[UILabel alloc]init];
    
//    searchIcon.image = ucm_imageName(@"ucm_centerModule_search", @"UCMCenterModule", nil);
//    [searchLab qmui_initWithFont:UIFontMake(14) textColor:UCM_999999_Color];
    searchLab.text = @"搜索订单号";
    self.header = header;
    self.searchView = searchView;
    
//    searchView.backgroundColor = UCM_F2F2F2_Color;
    // test
//    searchView.cornerRadius = 15;
    
    // 添加header
    [self.view addSubview:header];
    
    [header addSubview:searchView];
    [header addSubview:self.categoryTitleView];
    
    [searchView addSubview:searchContainer];
    [searchContainer addSubview:searchIcon];
    [searchContainer addSubview:searchLab];
    [searchView addSubview:searchCoverBtn];
    
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
    }];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
    }];
    [searchContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(17);
    }];
    [searchCoverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.equalTo(searchIcon.mas_right).offset(3);
    }];
    [self.categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(searchView);
        make.left.mas_equalTo(-20);
        make.right.mas_equalTo(20);
        make.top.equalTo(searchView.mas_bottom).offset(15);
        make.bottom.mas_equalTo(-15);
    }];
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 控制显示区域，即列表区域
    if (self.listContainerView.frame.size.width != self.view.frame.size.width || self.listContainerView.frame.size.height != self.view.frame.size.height - self.header.frame.size.height) {
        self.listContainerView.frame = CGRectMake(0, self.header.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.header.frame.size.height);
    }
}


- (void)reloadData {
    self.isReloadDataByOutside = YES;
    [self.listContainerView reloadData];
}

#pragma mark get ------
-(int)currentIndex {
    return self.s_currentIndex;
}

-(int)totalPage {
    return self.titles.count;
}

#pragma mark 搜索
-(void)tapSearch {
    
}



#pragma mark UCM_rebateSubNewTableViewDelegate

/* 后台：0已付款,1已收货,2已结算,-1已失效,默认为空代表全部订单 */
- (void)getDataWithParams:(NSDictionary *)dic tag:(NSInteger)tag isForLoadMore:(BOOL)isForLoadMore {
    
    
}

#pragma mark 点击cell   原代理方法返回值为void，即此处写成id 在项目导入时，QMUI库里会直接闪退的
- (id)tapCellAtIndex:(NSInteger)row model:(UCM_rebateModel *)model {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
    return [UIView new];
}

#pragma  mark - JXPagerViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.currentListView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
//    self.scrollCallback = callback;
}

- (void)listScrollViewWillResetContentOffset {
    //当前的listScrollView需要重置的时候，就把所有列表的contentOffset都重置了
//    for (UCM_rebateSubNewTableView *list in self.listContainerView.validListDict.allValues) {
//        list.contentOffset = CGPointZero;
//    }
}


#pragma mark - JXCategoryViewDelegate


- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //根据选中的下标，实时更新currentListView
    UCM_rebateSubNewTableView *list = (UCM_rebateSubNewTableView *)self.listContainerView.validListDict[@(index)];
    self.currentListView = list;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    UCM_rebateSubNewTableView *listView = self.listViewAry[index];
    
    listView.ucm_delegate = self;
    // 1.
    UCM_rebateSearchModel *searchModel = [[UCM_rebateSearchModel alloc]init];
    searchModel.ucm_type = self.searchModel.ucm_type;
    searchModel.keyboard = self.searchModel.keyboard;
    searchModel.orderId = self.searchModel.orderId;
    searchModel.date = self.searchModel.date;
    
    listView.searchModel = searchModel;
    
    // 2.
    UCM_rebateSubNewTableViewIndexType indexType = UCM_rebateSubNewTableViewIndexTypeAll;
    if (index == 0) { // 页面第0个位置
        indexType = UCM_rebateSubNewTableViewIndexTypeAll;
    } else if (index == 1) {
        indexType = UCM_rebateSubNewTableViewIndexTypeHavePay;
    } else if (index == 2) {
        indexType = UCM_rebateSubNewTableViewIndexTypeHaveGetThing;
    } else if (index == 3) {
        indexType = UCM_rebateSubNewTableViewIndexTypeHaveCloseCal;
    } else if (index == 4) {
        indexType = UCM_rebateSubNewTableViewIndexTypeHaveLoseEfi;
    }
    listView.ucm_index = indexType;
    
    
    [listView setup];
    
    if (self.isReloadDataByOutside) {
        self.isReloadDataByOutside = NO;
    } else {
        NSString *key = [NSString stringWithFormat:@"%d", index];
        BOOL isNeedBeginRefresh = [self.currentRequestListDic[key] boolValue];
        if (isNeedBeginRefresh) { // 首次
            [listView beginHeaderRefreshing];
        } else {
            
        }
    }
    
    
//    [listView beginHeaderRefreshing];
    
    // 3.
    self.currentListView = listView;
     
    // 4.
    return listView;
}


@end
