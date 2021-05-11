//
//  UCM_rebateNewContentCell.h
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/4.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UCM_rebateModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef void (^UCM_rebateNewContentCellTapMoreBlock)(int tag, UCM_rebateModel *model);

typedef void (^UCM_rebateNewContentCellCopyBlock)(void);

@interface UCM_rebateNewContentCell : UITableViewCell
@property (nonatomic, copy) UCM_rebateNewContentCellCopyBlock copyBolck;
@property (nonatomic, copy) UCM_rebateNewContentCellTapMoreBlock tapMoreBlock;

/// 模型
@property (nonatomic, strong) UCM_rebateModel *model;


@end

NS_ASSUME_NONNULL_END
