//
//  ViewController.m
//  Test_OC
//
//  Created by bavaria on 2021/1/25.
//  测试使用私有库

#import "ViewController.h"
#import "CLTestViewController.h"
#import <Masonry/Masonry.h>
#import "UCM_rebateViewController.h"
#import "TestQMUIViewController.h"
#import <SDWebImage/SDWebImage.h>
/// 处理webq格式的图片
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>

//#import <YYKit/YYKit.h>



//#import <TestBaseLabel/CLBaseLabel.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.
//    CLBaseLabel *baseLab = [[CLBaseLabel alloc]init];
    
    // 2. 只是pod库里有CLBaseLabel，但是此项目的任何地方都不引入，然后通过运行时调用, 可以正常调用
    
    Class cls = NSClassFromString(@"CLBaseLabel");
    SEL selector = NSSelectorFromString(@"initWithBgColor:");
    
    
    NSString *strsss;
    
    // 3.
//    UIImage *img = [UIImage imageNamed:@"cutImage"];
//    UIImage *newImg = [img stretchableImageWithLeftCapWidth:(80/200.0) * 200 topCapHeight:(130/200.0) * 200];
    
    // 3.1 图片的原始大小必须是小于imageView的尺寸的，否则会被压缩的
    
//    UIImage *img = [UIImage imageNamed:@"qipao_center"];
//    UIImage *newImg = [img stretchableImageWithLeftCapWidth:(199.99/200.0) * 350 topCapHeight:(140/200.0) * 200];
    
    // 3.2
    UIImage *img = [UIImage imageNamed:@"qipao1"];
    CGSize imgSize = img.size;
    UIImage *newImg = [img stretchableImageWithLeftCapWidth:(18/32.0) * imgSize.width topCapHeight:(15/32.0) * imgSize.height];
    
    // 3.3 使用新的可以被拉伸的图片
    UIImageView *imgV = [[UIImageView alloc]init];
    [self.view addSubview:imgV];
    // 本地图片
//    imgV.image = newImg;
    
    // 即图片尺寸<imageView的尺寸需要拉伸时，必须这样设置模式
    imgV.contentMode = UIViewContentModeScaleToFill;
    imgV.backgroundColor = [UIColor lightGrayColor];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(150);
    }];
    
    // 3.2 动图，sd时直接就支持的，无需做处理
    NSString *animteImageUrlStr = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fstatic.oschina.net%2Fuploads%2Fimg%2F201511%2F25145708_rMwq.gif&refer=http%3A%2F%2Fstatic.oschina.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621481727&t=422662121186bb9aa5f1cb546873fa2d";
    
    
    // 加载网络webq图片
    NSString *imgUrl = @"https://img-1.pddpic.com/goods/images/2019-05-15/e2c185f7-47af-4012-9a5b-742b5d05e5e3.jpg?imageView2/2/w/112/q/80/format/webp";
    // 4
    
    NSURL *url = [NSURL URLWithString:animteImageUrlStr];
    
    // 适配加载网络webp, 必须加上这两个
//    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
//    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
//
    [imgV sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    
//    NSData *webpData;
//    UIImage *image = [UIImage sd_imageWithWebPData:webpData];
//    imgV.image = image;
    
    // 4.1
//    imgV.yy_imageURL = [NSURL URLWithString:@"http://github.com/ani.webp"];
    
//    [imgV setImageWithURL:url placeholder:nil options:YYWebImageOptionRefreshImageCache completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//            
//    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // test  CLTestViewController  UCM_rebateViewController  TestQMUIViewController
    TestQMUIViewController *testVc = [[TestQMUIViewController alloc]init];
    [self.navigationController pushViewController:testVc animated:YES];
}

@end
