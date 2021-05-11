//
//  UCM_rebateTradeDateView.m
//  AFNetworking
//
//  Created by bavaria on 2021/2/2.
//  外部无需设置高度

#import "UCM_rebateTradeDateView.h"
#import "UCM_rebateModel.h"


@interface UCM_rebateTradeDateView ()
@property (nonatomic, strong) NSMutableArray *containers;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, strong) UIImage *image;
@end

@implementation UCM_rebateTradeDateView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup {
    self.containers = [NSMutableArray array];
    self.clipsToBounds = YES;
}

-(void)setModels:(NSArray *)models {
    _models = models;
    
    if (models.count == 0) {
        return;
    }
    
    self.isDown = ((UCMRebateTradeDateModel *)models[0]).isDown;
    
    // 如果是首次进来，则只设置一个view, 否则看isDown
    if (self.subviews.count == 0) {
        [self handleShowOne];
    } else {
        
        if (self.containers.count != 0) {
            for (UIView *sub in self.containers) {
                [sub removeFromSuperview];
            }
            [self.containers removeAllObjects];
        }
        
        if (!self.isDown) {
            [self handleShowOne];
        } else {
            [self handleShowAll];
        }
        
    }
    
    self.icon.hidden = self.models.count <= 1;
    
}

-(void)handleShowOne {
    
    
}

-(void)handleShowAll {
    
    
}
    
    
-(void)coverAction {
    self.isDown = !self.isDown;
    
//    if (self.models.count <= 1) {
//        return;
//    }
    if (self.ucm_updateLayoutblock) {
        self.ucm_updateLayoutblock(self.isDown);
    }
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.1 animations:^{
        if (self.isDown) {
            self.icon.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.icon.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    
    
}

@end
