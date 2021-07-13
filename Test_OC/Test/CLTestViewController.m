//
//  CLTestViewController.m
//  CLSETC
//
//  Created by bavaria on 2021/1/26.
//  Copyright © 2021 cls. All rights reserved.
//

#import "CLTestViewController.h"
#import "CLTestSharedView.h"
#import "CLTestSharedViewManager.h"
#import <Masonry/Masonry.h>

@interface CLTestViewController ()
@property (nonatomic, strong) UIButton *tapLab;
@end

@implementation CLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *tapLab = [[UIButton alloc]init];
    // 1.
//    CLTestSharedView *testView = CLTestSharedView.shared;
    // 2.
    CLTestSharedView *testView =  CLTestSharedViewManager.shared.view;
    
    
    [tapLab setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tapLab setTitle:@"点击999999" forState:UIControlStateNormal];
    self.tapLab = tapLab;
    
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    [self.view addSubview:tapLab];
    
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    [tapLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
    }];
    
    [tapLab addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)tapAction {
    // 1. 这种方式是无法销毁单利的，单利不可销毁
//    [CLTestSharedView.shared removeFromSuperview];
//    CLTestSharedView *sg = [CLTestSharedView shared];
//    sg = nil;
    
    // 2.
    [CLTestSharedViewManager.shared.view removeFromSuperview];
    CLTestSharedViewManager.shared.view = nil;
    
    // 3.
    NSSet *set = [NSSet new];
    set = [set setByAddingObject:@1];
    set = [set setByAddingObject:@{@"11": @"value"}];
    
    NSHashTable *a;
}


@end
