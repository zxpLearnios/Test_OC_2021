//
//  UCM_rebateTradeDateView.h
//  AFNetworking
//
//  Created by bavaria on 2021/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



typedef void (^UCM_rebateTradeDateViewUpdateLayoutBLock)(BOOL isDown);

@interface UCM_rebateTradeDateView : UIView

/// 里面放模型
@property (nonatomic, strong) NSArray *models;

@property (nonatomic, copy) UCM_rebateTradeDateViewUpdateLayoutBLock ucm_updateLayoutblock;
@end

NS_ASSUME_NONNULL_END
