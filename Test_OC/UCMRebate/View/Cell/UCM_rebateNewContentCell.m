//
//  UCM_rebateNewContentCell.m
//  UCMCenterModule
//
//  Created by bavaria on 2021/2/4.
//  列表cell 用于二级列表容器里的cell， 方式二的tableview使用

#import "UCM_rebateNewContentCell.h"
#import "UCM_rebateModel.h"
#import "UCM_rebateTradeDateView.h"

@interface UCM_rebateNewContentCell ()

@property (nonatomic, strong) UILabel *orderNoLab;

@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UIImageView *orderIcon;

/// 订单icon 订单名字
@property (nonatomic, strong) UILabel *orderNameLab;

/// 预估赚
@property (nonatomic, strong) UILabel *rebateLab;

@property (nonatomic, strong) UILabel *payMoneyDesLab;
@property (nonatomic, strong) UILabel *payMoneyLab;
@property (nonatomic, strong) UIImageView *userIcon;


@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UIImageView *userLevelIcon;
@property (nonatomic, strong) UILabel *userLevelLab;
/// 团队奖励
@property (nonatomic, strong) UILabel *rebateTypeLab;

@property (nonatomic, strong) UCM_rebateTradeDateView *tradeDateView;

@end

@implementation UCM_rebateNewContentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setup {
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *bgView = [[UIView alloc]init];
    
    UIImageView *markIcon = [[UIImageView alloc]init];
    
//    UILabel *orderNoDesLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:UCM_333333_Color];
//    UILabel *orderNoLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:UCM_333333_Color];
//    UIButton *copyBtn = [[UIButton alloc]init];
//    UIButton *copyCoverBtn = [[UIButton alloc]init];
//    UILabel *statusLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(13) textColor:UCM_FF0250_Color];
//
//    UIImageView *orderIcon = [[UIImageView alloc]init];
//    UILabel *orderNameLab = [[UILabel alloc] qmui_initWithFont:UIFontBoldMake(13) textColor:UCM_333333_Color];
//    UIView *rebateView = [[UIView alloc]init];
//    UILabel *rebateLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(12) textColor:UIColorWhite];
//
//
//    UILabel *payMoneyDesLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(12) textColor:UCM_333333_Color];
//    UILabel *payMoneyLab = [[UILabel alloc]init];
//
//
//    UIImageView *userIcon = [[UIImageView alloc]init];
//    UILabel *userNameLab = [[UILabel alloc] qmui_initWithFont:UIFontBoldMake(15) textColor:UCM_333333_Color];
//    UIImageView *userLevelIcon = [[UIImageView alloc]init];
//    UILabel *userLevelLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(11) textColor:UCM_333333_Color];
//    UILabel *rebateTypeLab = [[UILabel alloc] qmui_initWithFont:UIFontMake(11) textColor:UCM_333333_Color];
//    UCM_rebateTradeDateView *tradeDateView = [[UCM_rebateTradeDateView alloc]init];
//
//    bgView.backgroundColor = UIColorWhite;
//
////    bgView.cornerRadius = 5;
//    NSString *hintText = @"--";
//    markIcon.backgroundColor = UCM_FF0250_Color;
////    markIcon.cornerRadius = 1.5;
//    orderNoDesLab.text = @"订单编号：";
//    orderNoLab.text = hintText;
//
//    orderNameLab.numberOfLines = 2;
//
////    orderIcon.cornerRadius = 5;
//
//    rebateView.backgroundColor = UCM_FF0250_Color;
////    rebateView.cornerRadius = 9;
//    rebateLab.text = @"预估收益¥--";
//
//    payMoneyDesLab.text = @"付款金额";
//    payMoneyLab.attributedText = [[NSAttributedString alloc]initWithString:hintText];
//
//    UIImage *img = ucm_imageName(@"ucm_contentCopy", @"UCMCenterModule", nil);
//    [copyBtn setBackgroundImage:img forState:UIControlStateNormal];
//
////    userIcon.cornerRadius = 13;
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//
////        bgView.cornerRadius = 5;
////        markIcon.cornerRadius = 1.5;
////        orderIcon.cornerRadius = 5;
////        rebateView.cornerRadius = 9;
////        userIcon.cornerRadius = 13;
//    });
//
//    userNameLab.text = hintText;
//    userLevelLab.text = hintText;
//    rebateTypeLab.text = hintText;
//
//    self.orderNoLab = orderNoLab;
//    self.statusLab = statusLab;
//    self.orderIcon = orderIcon;
//    self.orderNameLab = orderNameLab;
//    self.rebateLab = rebateLab;
//    self.payMoneyDesLab = payMoneyDesLab;
//    self.payMoneyLab = payMoneyLab;
//
//    self.userIcon = userIcon;
//    self.userNameLab = userNameLab;
//    self.userLevelIcon = userLevelIcon;
//    self.userLevelLab = userLevelLab;
//    self.rebateTypeLab = rebateTypeLab;
//    self.tradeDateView = tradeDateView;
//
//    [self addSubview:bgView];
//    [bgView addSubview:markIcon];
//    [bgView addSubview:orderNoDesLab];
//    [bgView addSubview:orderNoLab];
//
//    [bgView addSubview:copyBtn];
//    [bgView addSubview:copyCoverBtn];
//    [bgView addSubview:statusLab];
//
//
//    [bgView addSubview:orderIcon];
//    [bgView addSubview:orderNameLab];
//    [bgView addSubview:rebateView];
//    [rebateView addSubview:rebateLab];
//
//
//    [bgView addSubview:payMoneyDesLab];
//    [bgView addSubview:payMoneyLab];
//    [bgView addSubview:userIcon];
//    [bgView addSubview:userNameLab];
//
//
//    [bgView addSubview:userLevelIcon];
//    [bgView addSubview:userLevelLab];
//    [bgView addSubview:rebateTypeLab];
//    [bgView addSubview:tradeDateView];
//
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(-10);
//    }];
//    [markIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(15);
//        make.width.mas_equalTo(3);
//        make.height.mas_equalTo(12);
//    }];
//    [orderNoDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(markIcon.mas_right).offset(3);
//        make.centerY.equalTo(markIcon);
//    }];
//    [orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(orderNoDesLab);
//        make.left.equalTo(orderNoDesLab.mas_right);
//    }];
//    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(orderNoDesLab);
//        make.left.equalTo(orderNoLab.mas_right).offset(3);
//        make.width.height.mas_equalTo(14);
//    }];
//    [copyCoverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(orderNoLab);
//        make.right.equalTo(copyBtn);
//    }];
//    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(orderNoDesLab);
//        make.right.mas_equalTo(-10);
//    }];
//    [orderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(markIcon);
//        make.top.equalTo(markIcon.mas_bottom).offset(12);
//        make.width.height.mas_equalTo(78);
//    }];
//    [orderNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(orderIcon.mas_right).offset(5);
//        make.top.equalTo(orderIcon).offset(2);
//        make.right.equalTo(statusLab);
//    }];
///// 设置抗压缩
////    [rebateLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    [rebateLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(5);
//        make.right.mas_equalTo(-5);
//        make.centerY.mas_equalTo(0);
//    }];
//
//    [rebateView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(orderIcon.mas_right).offset(3);
//        make.left.equalTo(orderNameLab);
//        make.bottom.equalTo(orderIcon).offset(-2);
//        make.height.mas_equalTo(18);
//    }];
//
//    [payMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(statusLab);
//        make.centerY.equalTo(payMoneyDesLab);
//    }];
//    [payMoneyDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(payMoneyLab.mas_left).offset(-2);
//        make.centerY.equalTo(rebateView);
//    }];
//
//    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(26);
//        make.left.equalTo(orderIcon);
//        make.top.equalTo(orderIcon.mas_bottom).offset(18);
//    }];
//    [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(userIcon);
//        make.left.equalTo(userIcon.mas_right).offset(3);
//    }];
//
//    // 自适应图片的大小
//    userLevelIcon.contentMode = UIViewContentModeScaleAspectFit;
//    [userLevelIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(userIcon);
//        make.width.mas_equalTo(14);
//        make.height.mas_lessThanOrEqualTo(14);
//        make.left.equalTo(userNameLab.mas_right).offset(2);
//    }];
//    [userLevelLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(userIcon);
//        make.left.equalTo(userLevelIcon.mas_right).offset(2);
//    }];
//
//    [tradeDateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(userIcon.mas_bottom).offset(10);
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(-10);
//        // 此种二级列表方式必须设置此，否则布局会错乱
//        make.height.mas_greaterThanOrEqualTo(16);
//    }];
//
//    @weakify(self);
//    tradeDateView.ucm_updateLayoutblock = ^(BOOL isDown) {
//        self.model.isDown = isDown;
//        for (UCMRebateTradeDateModel *dateModel in self.model.dateModels) {
//            dateModel.isDown = isDown;
//        }
//        if (self.tapMoreBlock) {
//            self.tapMoreBlock(self.tag, self.model);
//        }
//    };
//
//
//    copyCoverBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
//        [self copyAction];
//    };
}

-(void)copyAction {
//    UIPasteboard *pb = [UIPasteboard generalPasteboard];
//    if ([self.orderNoLab.text isEqual:@"--"] || self.orderNoLab.text.length == 0) {
//
//    } else {
//        pb.string = self.orderNoLab.text;
//        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//        [keyWindow makeToast:@"复制成功" duration:0.1 position:CSToastPositionCenter];
//
//        if (self.copyBolck) {
//            self.copyBolck();
//        }
//    }
}

-(void)setModel:(UCM_rebateModel *)model {
    _model = model;
    if (self.tag % 2 == 0) {
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    
}

@end
