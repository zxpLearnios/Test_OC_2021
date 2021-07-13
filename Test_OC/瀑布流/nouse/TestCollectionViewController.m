//
//  TestCollectionViewController.m
//  Test_OC
//
//  Created by bavaria on 2021/7/11.
//

#import "TestCollectionViewController.h"
#import "TestCollectionViewCell.h"
#import "TestWaterFlowLayout.h"

@interface TestCollectionViewController () <TestWaterFlowLayoutDelegate>
{
    NSString *cellId;
}
@end

@implementation TestCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellId = @"TestCollectionViewCell";
    
    //设置瀑布流布局
    TestWaterFlowLayout *layout = [TestWaterFlowLayout new];
//    layout.columnCount = 3;
//    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 10);
//    layout.rowMargin = 20;
//    layout.columnMargin = 10;
    layout.delegate = self;
    
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    
}


#pragma mark WaterFlowLayoutDelegate

- (CGFloat)waterFlowLayout:(TestWaterFlowLayout *)waterFlowLayout heigthForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return indexPath.row % 2 == 0 ? 100 : 150;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 2) {
        return 30;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor grayColor];
    } else {
        cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了--%ld", indexPath.row);
}

#pragma mark UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.row % 2 == 0) {
//        return CGSizeMake(80, 160);
//    } else {
//        return CGSizeMake(100, 100);
//    }
//}


@end
