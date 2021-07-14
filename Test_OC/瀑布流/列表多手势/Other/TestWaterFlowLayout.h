//
//  ShopWaterLayout.h
//  集合视图之瀑布流
//
//  Created by ma c on 15/11/21.
//  Copyright (c) 2015年 夏远全. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestWaterFlowLayout;

@protocol TestWaterFlowLayoutDelegate <NSObject>

/**
 *  计算每一个item高度
 *
 *  @param waterFlowLayout 布局
 *  @param indexPath       位置
 *  @param itemWidth       每一行的宽度
 *
 *  @return 每一行的高度
 */
- (CGFloat)waterFlowLayout:(TestWaterFlowLayout *)waterFlowLayout heigthForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 *  返回四周的间距，默认是UIEdgeInsetsMake(10, 10, 10, 10)
 */
- (UIEdgeInsets)insetsInWaterFlowLaout:(TestWaterFlowLayout *)waterFlowLayout;
/**
 *  返回最大的列数, 默认是3
 */
- (int)maxColumnsInWaterFlowLaout:(TestWaterFlowLayout *)waterFlowLayout;
/**
 *  返回每行的间距, 默认是10
 */
- (CGFloat)rowMarginInWaterFlowLaout:(TestWaterFlowLayout *)waterFlowLayout;
/**
 *  返回每列的间距, 默认是10
 */
- (CGFloat)columnMarginInWaterFlowLaout:(TestWaterFlowLayout *)waterFlowLayout;


@end

@interface TestWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak)id<TestWaterFlowLayoutDelegate> delegate;
/// 告知外部最高列的高度，方便外部列表及时更新每行高度，适用于存放内部列表的cell.frame完全==最高列的高度
@property (nonatomic, copy) void (^getMaxColumnBlock)(double height);
@end
