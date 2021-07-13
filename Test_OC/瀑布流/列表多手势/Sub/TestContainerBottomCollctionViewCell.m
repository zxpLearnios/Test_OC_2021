//
//  TestContainerBottomCollctionViewCell.m
//  Test_OC
//
//  Created by bavaria on 2021/7/12.
//

#import "TestContainerBottomCollctionViewCell.h"
#import <Masonry/Masonry.h>

@interface TestContainerBottomCollctionViewCell ()
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation TestContainerBottomCollctionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        UILabel *titleLab = [UILabel new];
        self.titleLab = titleLab;
        
        [self.contentView addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setText:(NSString *)text {
    self.titleLab.text = text;
}

@end
