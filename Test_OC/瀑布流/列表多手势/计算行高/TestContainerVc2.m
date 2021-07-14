//
//  TestContainerVc2.m
//  Test_OC
//
//  Created by bavaria on 2021/7/14.
//  0. 方式2
//  1. 跟TestContainerVc一样，只不过这里存放 子列表的cell的height跟子列表的高度完全一致，同时禁止子列表滚动
//  2. 起始这种方式可以适应任何情况，即存放 子列表的cell在哪一行都行，主列表有无footer都可以
//  3. 此时无需持有btmCell, 否则在刷新高度时，需要btmCell=nil 在reloadData

#import "TestContainerVc2.h"
#import "TestContainerTopCell.h"
#import "TestContainerBottomCell2.h"
#import "Masonry.h"
//#import "TestGestureTableView.h"


@interface TestContainerVc2 () <UITableViewDelegate, UITableViewDataSource>
{
    
    int maxRow;
    
    NSString *topCellid;
    NSString *btmCellId;
    // 第一次是否是出发点在主列表上，防止手势开始时在最外部的列表cell时导致此列表无法滚动
    BOOL isPanMainListView;
    double maxOffsetY;
}
//@property (nonatomic, assign) BOOL superCanScroll;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TestContainerBottomCell2 *btmcell;
// 存放子列表的cell在第几行或组
@property (nonatomic, assign) int cellListRow;
@property (nonatomic, strong) NSMutableArray *rowHeights;;
@end

@implementation TestContainerVc2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowHeights = [NSMutableArray array];
    maxRow = 4;
    self.cellListRow = 2;
    
    for (int i=0; i<maxRow; i++) {
        [self.rowHeights addObject:@200];
    }
    
    maxOffsetY = 200;
//    self.superCanScroll = YES;
    
    topCellid = @"TestContainerTopCell";
    btmCellId = @"TestContainerBottomCell2";
    
    UITableView *mainTableView = [UITableView new];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    // 根据具体的外部列表最大滚动距离 来 决定 是否禁止外部列表的bounces
//    mainTableView.bounces = NO;
    
    self.mainTableView = mainTableView;
    
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [mainTableView registerClass:[TestContainerTopCell class] forCellReuseIdentifier:topCellid];
    [mainTableView registerClass:[TestContainerBottomCell2 class] forCellReuseIdentifier:btmCellId];
     
    
    __weak typeof(self) weakSelf = self;
//    mainTableView.touchBeganBlock = ^(NSSet<UITouch *> * _Nonnull touches, UIEvent * _Nonnull event) {
//        [weakSelf touchesBegan:touches withEvent:event];
//    };
    
    // 加此手势是为了处理：当手势首次触发时在非‘装子列表的cell’时，会导致主列表无法滚动的问题
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    [mainTableView addGestureRecognizer:pan];
}

- (void)dealloc
{
    NSLog(@"TestContainerVc2----dealloc");
}

//-(void)panAction:(UIPanGestureRecognizer *)pan {
//    UIGestureRecognizerState state = pan.state;
//    if (state == UIGestureRecognizerStateBegan) {
//        isPanMainListView = YES;
//        NSLog(@"手势开始");
//    } else if (state == UIGestureRecognizerStateCancelled || state ==  UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateFailed) {
//        NSLog(@"手势结束");
//    }
//}

#pragma mark UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
////    NSLog(@"父scrollView的滚动距离：%f", scrollView.contentOffset.y);
//    if (isPanMainListView) {
//        return;
//    } else {
////        NSLog(@"00000000000111111");
//        if (!self.superCanScroll) {
//            scrollView.contentOffset = CGPointMake(0, maxOffsetY);
//            self.btmcell.childCanScroll = YES;
//        } else {
//            if (scrollView.contentOffset.y >= maxOffsetY) {
//                scrollView.contentOffset = CGPointMake(0, maxOffsetY);
//                self.superCanScroll = NO;
//                self.btmcell.childCanScroll = YES;
//            }
//        }
//    }
//
//}

#pragma mark 手势拖拽 滚动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isPanMainListView) {
        isPanMainListView = NO;
    }
}

#pragma mark 自动滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"滚动结束");
    
}

#pragma mark 注释
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches  anyObject];
    NSString *str = (touch.view == self.btmcell) ? @"在子列表上" : @"不在子列表上";
//    NSLog(@"点击手势开始时，%@", str);
}



#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return maxRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.cellListRow) {
        if (!self.btmcell) {
            TestContainerBottomCell2 *btmcell = [tableView dequeueReusableCellWithIdentifier:btmCellId forIndexPath:indexPath];
            btmcell.backgroundColor = [UIColor blueColor];
            self.btmcell = btmcell;
        }
        
        __weak typeof(self) weakSelf = self;
//        self.btmcell.superCanScrollBlock = ^(BOOL superCanScroll) {
//            weakSelf.superCanScroll = superCanScroll;
//        };
        self.btmcell.getMaxColumnBlock = ^(double height) {
            weakSelf.rowHeights[weakSelf.cellListRow] = [NSNumber numberWithDouble:height];
            // 更新
            [weakSelf.mainTableView reloadData];
            
            // 1. 重置 被self持有的存放子列表的cell(主列表是tableView好像没问题，但是collectionview时一定有问题)
            weakSelf.btmcell = nil;
#warning 如果主列表是collectionview时，则需要这样设置
            /*UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            weakSelf.collectionView.collectionViewLayout = layout;
             即重置主列表的collectionViewLayout并在此随便赋个值，然后触发sizeForItemAtIndexPath即可正确布局
             // 更新列表
             [weakSelf.collectionView reloadData];
             */
            
        };
        return self.btmcell;
    } else {
        TestContainerTopCell *topcell = [tableView dequeueReusableCellWithIdentifier:topCellid forIndexPath:indexPath];
        topcell.backgroundColor = (indexPath.section % 2 == 0) ? [UIColor grayColor] : [UIColor redColor];
        return topcell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeights[indexPath.section] doubleValue];
}

@end
