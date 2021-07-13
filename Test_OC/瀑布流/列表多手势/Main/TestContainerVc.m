//
//  TestContainerVc.m
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//  1. 当存放子列表的cell在最底部时
//  2. 当存放子列表的cell不在最底部时
//  3. 不加pan手势的话，当手势首次响应者是container列表时(即它的的cell)时，这时候当手势结束后再次滑动外部列表会无法在滑动，因为没有触发子列表的回调没有设置superCanScroll
// 4. 根据具体的外部列表最大滚动距离 来 决定 是否禁止外部列表的bounces。
//  5.  主列表、子列表都可以设置 bounces=yes

#import "TestContainerVc.h"
#import "TestContainerTopCell.h"
#import "TestContainerBottomCell.h"
#import "Masonry.h"
#import "TestGestureTableView.h"


@interface TestContainerVc () <UITableViewDelegate, UITableViewDataSource>
{
    int maxRow;
    NSString *topCellid;
    NSString *btmCellId;
    // 第一次是否是出发点在主列表上，防止手势开始时在最外部的列表cell时导致此列表无法滚动
    BOOL isPanMainListView;
    double maxOffsetY;
}
@property (nonatomic, assign) BOOL superCanScroll;
@property (nonatomic, strong) TestGestureTableView *mainTableView;
@property (nonatomic, strong) TestContainerBottomCell *btmcell;
@end

@implementation TestContainerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxRow = 4;
    maxOffsetY = 100;
    self.superCanScroll = YES;
    
    topCellid = @"TestContainerTopCell";
    btmCellId = @"TestContainerBottomCell";
    
    TestGestureTableView *mainTableView = [TestGestureTableView new];
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
    [mainTableView registerClass:[TestContainerBottomCell class] forCellReuseIdentifier:btmCellId];
     
    
    __weak typeof(self) weakSelf = self;
    mainTableView.touchBeganBlock = ^(NSSet<UITouch *> * _Nonnull touches, UIEvent * _Nonnull event) {
        [weakSelf touchesBegan:touches withEvent:event];
    };
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [mainTableView addGestureRecognizer:pan];
}

- (void)dealloc
{
    
}

-(void)panAction:(UIPanGestureRecognizer *)pan {
    UIGestureRecognizerState state = pan.state;
    if (state == UIGestureRecognizerStateBegan) {
        isPanMainListView = YES;
        NSLog(@"手势开始");
    } else if (state == UIGestureRecognizerStateCancelled || state ==  UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateFailed) {
        NSLog(@"手势结束");
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"父scrollView的滚动距离：%f", scrollView.contentOffset.y);
    if (isPanMainListView) {
        return;
    } else {
//        NSLog(@"00000000000111111");
        if (!self.superCanScroll) {
            scrollView.contentOffset = CGPointMake(0, maxOffsetY);
            self.btmcell.childCanScroll = YES;
        } else {
            if (scrollView.contentOffset.y >= maxOffsetY) {
                scrollView.contentOffset = CGPointMake(0, maxOffsetY);
                self.superCanScroll = NO;
                self.btmcell.childCanScroll = YES;
            }
        }
    }
    
}

#pragma mark 手势拖拽 滚动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isPanMainListView) {
        isPanMainListView = NO;
    }
}

#pragma mark 自动滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"滚动结束");
    
}

#pragma mark 注释
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches  anyObject];
    NSString *str = (touch.view == self.btmcell) ? @"在子列表上" : @"不在子列表上";
    NSLog(@"点击手势开始时，%@", str);
}



#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return maxRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == maxRow-2) {
        if (!self.btmcell) {
            TestContainerBottomCell *btmcell = [tableView dequeueReusableCellWithIdentifier:btmCellId forIndexPath:indexPath];
            btmcell.backgroundColor = [UIColor blueColor];
            self.btmcell = btmcell;
        }
        
        __weak typeof(self) weakSelf = self;
        self.btmcell.superCanScrollBlock = ^(BOOL superCanScroll) {
            weakSelf.superCanScroll = superCanScroll;
        };
        return self.btmcell;
    } else {
        TestContainerTopCell *topcell = [tableView dequeueReusableCellWithIdentifier:topCellid forIndexPath:indexPath];
        topcell.backgroundColor = (indexPath.section % 2 == 0) ? [UIColor grayColor] : [UIColor redColor];
        return topcell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == maxRow-2 ? 400 : 200;
}

@end
