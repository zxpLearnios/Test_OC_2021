//
//  TestContainerBottomCell2.m
//  Test_OC
//
//  Created by bavaria on 2021/7/14.
//  跟TestContainerBottomCell一样。 可以bounce, 列表禁不禁止滚动都行，最好禁止

#import "TestContainerBottomCell2.h"
#import "TestContainerBottomCollctionView.h"
#import "Masonry.h"
#import "TestWaterFlowLayout.h"
#import "TestContainerBottomCollctionViewCell.h"


@interface TestContainerBottomCell2 () <UICollectionViewDelegate, UICollectionViewDataSource, TestWaterFlowLayoutDelegate>

{
    NSString *cellid;
   
}
@property (nonatomic, strong) TestContainerBottomCollctionView *listView;
@end

@implementation TestContainerBottomCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    cellid = @"TestContainerBottomCollctionViewCell";
    
    TestWaterFlowLayout *layout = [TestWaterFlowLayout new];
    TestContainerBottomCollctionView *listView = [[TestContainerBottomCollctionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.listView = listView;
    [self.contentView addSubview:listView];
    
    layout.delegate = self;
    listView.backgroundColor = [UIColor whiteColor];
    listView.delegate = self;
    listView.dataSource = self;
    listView.scrollEnabled = NO;
    listView.collectionViewLayout = layout;
    
    [listView registerClass:[TestContainerBottomCollctionViewCell class] forCellWithReuseIdentifier:cellid];
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    __weak typeof(self) weakSelf = self;
    layout.getMaxColumnBlock = ^(double height) {
        NSLog(@"TestContainerBottomCell2 收到存放子列表cell-它的列表最大高度的回调了");
        if (weakSelf.getMaxColumnBlock) {
            weakSelf.getMaxColumnBlock(height);
        }
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark TestWaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(TestWaterFlowLayout *)waterFlowLayout heigthForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    NSInteger row = indexPath.row;
    if (row == 0) {
        return 60;
    } else if (row == 1) {
        return 40;
    } else if (row == 2) {
        return 40;
    } else {
        return row % 2 == 0 ? 100 : 70;
    }
}

#pragma mark UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"子scrollView的滚动距离：%f", scrollView.contentOffset.y);
//
//    if (!self.childCanScroll) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    } else {
//        if (scrollView.contentOffset.y <= 0) {
//            self.childCanScroll = NO;
//            if (self.superCanScrollBlock) {
//                self.superCanScrollBlock(YES);
//            }
//        }
//    }
//}


#pragma mark UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestContainerBottomCollctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"title-%ld", indexPath.row];
    [cell setText:str];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了%ld---%ld", indexPath.section, indexPath.row);
}

@end
