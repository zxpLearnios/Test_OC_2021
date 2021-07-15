//
//  QNResidueDateView.m
//  MillenniumGourd
//
//  Created by bavaria on 2021/7/15.
//  Copyright © 2021 Qian Nian Tech. All rights reserved.
//  0. 样式为: *：天数：时数：分数：秒数：
//  1. 如果时列表的话，就在列表控制器里加定时器，计算出天时分秒不停的回调给这里即可
//  2. 宽度、高度已经确定了

#import "TLResidueDateView.h"
#import <Masonry/Masonry.h>

@interface TLResidueDateView ()
@property (nonatomic, strong) NSMutableArray <UILabel *> *datelabs;
@property (nonatomic, strong) NSMutableArray <UILabel *> *seplabs;
@end

@implementation TLResidueDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup {
    self.datelabs = [NSMutableArray array];
    self.seplabs = [NSMutableArray array];
    
    for (int i=0; i<5; i++) {
        UILabel *dateLab = [UILabel new];
        UILabel *sepLab = [UILabel new];
        
        dateLab.backgroundColor = [UIColor grayColor];
        dateLab.textColor = [UIColor redColor];
        dateLab.font = [UIFont boldSystemFontOfSize:13];;
        dateLab.layer.cornerRadius = 2;
        dateLab.layer.masksToBounds = YES;
        dateLab.text = @"--";
        dateLab.textAlignment = NSTextAlignmentCenter;
        
        sepLab.text = @":";
        sepLab.textAlignment = NSTextAlignmentCenter;
        sepLab.textColor = [UIColor orangeColor];
        sepLab.font = [UIFont boldSystemFontOfSize:13];
        
        [self.datelabs addObject:dateLab];
        [self.seplabs addObject:sepLab];
        
        [self addSubview:dateLab];
        [self addSubview:sepLab];
        
        // 从右往左  *：天数：时数：分数：秒数：
        if (i == 0) {
            sepLab.text = @"";
            [sepLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.mas_equalTo(0);
            }];
            [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.right.equalTo(sepLab.mas_left);
                make.width.mas_greaterThanOrEqualTo(18);
                make.height.mas_greaterThanOrEqualTo(16);
            }];
        } else {
            UILabel *lastDateLab = self.datelabs[i - 1];
            UILabel *lastSeplab = self.seplabs[i - 1];
            [sepLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(lastSeplab);
                make.right.equalTo(lastDateLab.mas_left);
            }];
            [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.width.height.equalTo(lastDateLab);
                make.right.equalTo(sepLab.mas_left);
            }];
            
            if (i == 4) { // 最后一个，即最左边的label隐藏
                dateLab.text = @"start";
                sepLab.text = @"";
                [dateLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.mas_equalTo(0);
                    make.height.equalTo(lastDateLab);
                    make.width.mas_equalTo(0);
                    make.right.equalTo(sepLab.mas_left);
                    make.left.mas_equalTo(0);
                }];
            }
        }
        
    }
}

-(void)setDay:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute second:(NSString *)second {
    if (self.datelabs.count <= 0) {
        return;
    }
    
    self.datelabs[3].text = day;
    self.datelabs[2].text = hour;
    self.datelabs[1].text = minute;
    self.datelabs[0].text = second;
}

-(void)setDayUnit:(NSString *)dayUnit hourUnit:(NSString *)hourUnit minuteUnit:(NSString *)minuteUnit secondUnit:(NSString *)secondUnit {
    // 样式为:  *：天数：时数：分数：秒数：
    if (self.seplabs.count <= 0) {
        return;
    }
    
    self.seplabs[3].text = dayUnit;
    self.seplabs[2].text = hourUnit;
    self.seplabs[1].text = minuteUnit;
    self.seplabs[0].text = secondUnit;
}

-(void)setDateFont:(UIFont *)dateFont sepLabelFont:(UIFont *)sepLabelFont {
    for (UILabel *dateLab in self.datelabs) {
        dateLab.font = dateFont;
    }
    for (UILabel *seplab in self.seplabs) {
        seplab.font = sepLabelFont;
    }
}



@end
