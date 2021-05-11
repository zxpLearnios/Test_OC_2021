//
//  UCM_rebateSubNewTableView.m
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/4.
//  方式二。返佣二级列表，
//  由于二级列表是collectionview，item是这个tableView，所以ableView 的所有数据源需要外部容器控制器 【处理并对号记录】，解决item的重用

#import "UCM_rebateSubNewTableView.h"
#import "UCM_rebateNewContentCell.h"

#import <MJRefresh/MJRefresh.h>


@interface UCM_rebateSubNewTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *cellId;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) BOOL isForLoadMore;
@property (nonatomic, assign) int currentPage;
@end

@implementation UCM_rebateSubNewTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupHeader];
        [self setupFooter];
        // 先隐藏底部刷新控件
        self.mj_footer.hidden = YES;
    }
    return self;
}

/// 外部调用，防止某些数据在初始化时还没有
-(void)setup {
    
    self.currentPage = 1;
    self.cellId = @"UCM_rebateNewContentCell_id";
    
    
    self.contentInset = UIEdgeInsetsMake(10, 0, 30, 0);
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footer = [[UIView alloc]init];
    self.tableFooterView = footer;
    
    // 此框自动布局会有问题
//    self.estimatedRowHeight = 207;
//    self.rowHeight = UITableViewAutomaticDimension;
    
    [self registerClass:[UCM_rebateNewContentCell class] forCellReuseIdentifier:self.cellId];
    self.dataSource = self;
    self.delegate = self;
}


//------------------ public  ------------------

-(void)beginHeaderRefreshing {
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
    [self.mj_header beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
    });
}

-(void)endHeaderRefreshing {
    [self.mj_header endRefreshing];
}


-(void)beginFootererRefreshing {
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    [self.mj_footer beginRefreshing];
}


-(void)endFootererRefreshing {
    [self.mj_footer endRefreshing];
}


// ----------------- private ----------------
/// 设置下啦刷新
- (void)setupHeader {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    header.ignoredScrollViewContentInsetTop = 20;
    self.mj_header = header;
}

/// 设置上啦刷新
- (void)setupFooter {
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.mj_footer = footer;
}


-(void)headerRefresh {
    self.isForLoadMore = NO;
}

-(void)footerRefresh {
    self.isForLoadMore = YES;
}





#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self;
}


#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UCM_rebateNewContentCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellId forIndexPath:indexPath];
   
    __weak typeof(self) weakself = self;
    
    cell.tapMoreBlock = ^(int tag, UCM_rebateModel * _Nonnull model) {
        
        // 无动画刷新tableview
        [UIView performWithoutAnimation:^{
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:tag inSection:0];
            [weakself reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    cell.tag = indexPath.row;
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.model = weakself.models[indexPath.row];
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.ucm_delegate && [self.ucm_delegate respondsToSelector:@selector(tapCellAtIndex:model:)]) {
        [self.ucm_delegate tapCellAtIndex:row model:self.models[row]];
    }
}

@end
