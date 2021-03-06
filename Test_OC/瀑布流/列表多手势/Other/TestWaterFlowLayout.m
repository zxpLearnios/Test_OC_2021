//
//  QNProductWaterFlowLayout.m
//  MillenniumGourd
//
//  Created by bavaria on 2021/7/12.
//  Copyright © 2021 Qian Nian Tech. All rights reserved.
//  瀑布流布局

#import "TestWaterFlowLayout.h"

//默认列数
static const int RADefaultMaxColumns = 3;
//默认行间距
static const CGFloat RADefaultRowMargin = 10;
//默认列间距
static const CGFloat RADefaultColumnsMargin = 10;
//默认距离屏幕边距
static const UIEdgeInsets RADefaultInsets = {10,10,10,10};

@interface TestWaterFlowLayout ()
{
    /// 存储首次得出的最高列的高度
    double lastMaxHeight;
}
//存放每一列最大Y值
@property (strong,nonatomic)NSMutableArray *maxYs;

/// 存储首次得出的最高列的高度
//@property (nonatomic, assign) double lastMaxHeight;
@property (strong,nonatomic)NSMutableArray *attrsArray;

@end

@implementation TestWaterFlowLayout

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

- (NSMutableArray *)maxYs
{
    if (!_maxYs) {
        self.maxYs = [[NSMutableArray alloc] init];
    }
    return _maxYs;
}

- (void)prepareLayout{

    // 初始化最大y值数组
    [self.maxYs removeAllObjects];
    int maxColumns = self.maxColumns;
    for (NSUInteger i = 0; i < maxColumns; i++) {
        [self.maxYs addObject:@(self.insets.top)];
    }
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }

}
//显示范围发生改变的时候会重新刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{

    return YES;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attrsArray;
}

/**
 *  indexPath这个位置对应cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //每一列的间距
    CGFloat columnMargin = [self columnMargin];
    
    CGFloat rowMargin = [self rowMargin];
    
    int maxColumns = [self maxColumns];
    
    UIEdgeInsets insets = [self insets];
    
    CGFloat collectionViewW = self.collectionView.bounds.size.width;
    
    CGFloat itemW = (collectionViewW - insets.left - insets.right - (maxColumns - 1) * columnMargin) / maxColumns;
    
    //询问代理item的高度
    CGFloat itemH = [self.delegate waterFlowLayout:self heigthForItemAtIndexPath:indexPath itemWidth:itemW];
    
    //创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat minMaxY = [self.maxYs[0] doubleValue];
    int minColumn = 0;
    
    for (int i = 1; i < maxColumns; i++) {
        
        CGFloat maxY = [self.maxYs[i] doubleValue];
        
        if (maxY < minMaxY) {
            
            minMaxY = maxY;
            
            minColumn = i;
        }
    }
    
    CGFloat itemX = insets.left + minColumn * (itemW + columnMargin);
    CGFloat itemY = minMaxY + rowMargin;
    
    
    attrs.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
    self.maxYs[minColumn] = @(CGRectGetMaxY(attrs.frame));
    return attrs;
}

#pragma mark  最大滚动距离
- (CGSize)collectionViewContentSize {
    CGFloat longMaxY = 0;
    if (self.maxYs.count) {
        longMaxY = [self.maxYs[0] doubleValue]; // 最长那一列 的 最大Y值
        for (int i = 1; i < self.maxColumns; i++) {
            CGFloat maxY = [self.maxYs[i] doubleValue];
            if (maxY > longMaxY) {
                longMaxY = maxY;
            }
        }
        
        // 累加底部的间距
        longMaxY += self.insets.bottom;
    }
    if (lastMaxHeight != longMaxY) {
        if (self.getMaxColumnBlock) {
            self.getMaxColumnBlock(longMaxY);
        }
        
        lastMaxHeight = longMaxY;
    }
    return CGSizeMake(0, longMaxY);
}

#pragma mark - 私有方法(获得代理返回的数字)
- (int)maxColumns
{
    if ([self.delegate respondsToSelector:@selector(maxColumnsInWaterFlowLaout:)]) {
        return [self.delegate maxColumnsInWaterFlowLaout:self];
    }
    return RADefaultMaxColumns;
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLaout:)]) {
        return [self.delegate rowMarginInWaterFlowLaout:self];
    }
    return RADefaultRowMargin;
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLaout:)]) {
        return [self.delegate columnMarginInWaterFlowLaout:self];
    }
    return RADefaultColumnsMargin;
}

- (UIEdgeInsets)insets
{
    if ([self.delegate respondsToSelector:@selector(insetsInWaterFlowLaout:)]) {
        return [self.delegate insetsInWaterFlowLaout:self];
    }
    return RADefaultInsets;
}

@end
