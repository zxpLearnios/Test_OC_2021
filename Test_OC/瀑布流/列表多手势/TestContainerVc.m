//
//  TestContainerVc.m
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//

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
    // 第一次是否是出发点在主列表上
    BOOL isPanMainListView;
    double maxOffsetY;
}
@property (nonatomic, assign) BOOL superCanScroll;
@property (nonatomic, strong) TestGestureTableView *tv;
@property (nonatomic, strong) TestContainerBottomCell *btmcell;
@end

@implementation TestContainerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxRow = 4;
    maxOffsetY = 130;
    self.superCanScroll = YES;
    
    topCellid = @"1";
    btmCellId = @"2";
    
    TestGestureTableView *tv = [TestGestureTableView new];
    tv.delegate = self;
    tv.dataSource = self;
    tv.bounces = NO;
    
    self.tv = tv;
    
    [self.view addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [tv registerClass:[TestContainerTopCell class] forCellReuseIdentifier:topCellid];
    [tv registerClass:[TestContainerBottomCell class] forCellReuseIdentifier:btmCellId];
     
    
    __weak typeof(self) weakSelf = self;
    tv.touchBeganBlock = ^(NSSet<UITouch *> * _Nonnull touches, UIEvent * _Nonnull event) {
        [weakSelf touchesBegan:touches withEvent:event];
    };
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [tv addGestureRecognizer:pan];
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
        NSLog(@"00000000000111111");
        if (!self.superCanScroll) {
            scrollView.contentOffset = CGPointMake(0, maxOffsetY);
            self.btmcell.childCanScroll = YES;
        } else {
            if (scrollView.contentOffset.y >= maxOffsetY) {
                scrollView.contentOffset = CGPointMake(0, maxOffsetY);
                self.superCanScroll = NO;
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
    if (indexPath.section == maxRow-1) {
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
        topcell.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor grayColor] : [UIColor redColor];
        return topcell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == maxRow-1 ? 500 : 200;
}

@end
