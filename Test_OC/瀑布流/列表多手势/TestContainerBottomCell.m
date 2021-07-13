//
//  TestContainerBottomCell.m
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//

#import "TestContainerBottomCell.h"
#import "TestContainerBottomCollctionView.h"
#import "Masonry.h"
#import "TestWaterFlowLayout.h"
#import "TestContainerBottomCollctionViewCell.h"



@interface TestContainerBottomCell () <UICollectionViewDelegate, UICollectionViewDataSource, TestWaterFlowLayoutDelegate>

{
    NSString *cellid;
   
}
@property (nonatomic, strong) TestContainerBottomCollctionView *tv;
@end

@implementation TestContainerBottomCell


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
    layout.delegate = self;
    
    TestContainerBottomCollctionView *tv = [[TestContainerBottomCollctionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    tv.collectionViewLayout = layout;
    
    tv.delegate = self;
    tv.dataSource = self;
    
    
    self.tv = tv;
    [self.contentView addSubview:tv];
    
    
    
    
    [tv registerClass:[TestContainerBottomCollctionViewCell class] forCellWithReuseIdentifier:cellid];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    

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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"子scrollView的滚动距离：%f", scrollView.contentOffset.y);
    
    if (!self.childCanScroll) {
        scrollView.contentOffset = CGPointMake(0, 0);
    } else {
        if (scrollView.contentOffset.y <= 0) {
            self.childCanScroll = NO;
            if (self.superCanScrollBlock) {
                self.superCanScrollBlock(YES);
            }
        }
    }
}


#pragma mark UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestContainerBottomCollctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"title-%ld", indexPath.row];
    [cell setText:str];
    return cell;
}


@end
