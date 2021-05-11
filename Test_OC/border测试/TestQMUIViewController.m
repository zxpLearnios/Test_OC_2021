//
//  TestQMUIViewController.m
//  Test_OC
//
//  Created by bavaria on 2021/3/18.
//

#import "TestQMUIViewController.h"
#import <Masonry/Masonry.h>
#import <QMUIKit/QMUIKit.h>

@interface TestQMUIViewController ()

@end

@implementation TestQMUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    view.layer.cornerRadius = 20;
    view.qmui_borderWidth = 2;
    view.qmui_borderColor = [UIColor greenColor];
    view.qmui_borderPosition = QMUIViewBorderPositionTop;
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    
    
}



@end
