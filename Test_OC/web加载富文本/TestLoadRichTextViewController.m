//
//  TestLoadRichTextViewController.m
//  Test_OC
//
//  Created by bavaria on 2021/7/17.
//

#import "TestLoadRichTextViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface TestLoadRichTextViewController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation TestLoadRichTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]init];
    
    self.webView = webView;
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
    NSString *richText = @"<p>阿斯顿撒sadd去问问qsa旦臭小子创造性czx</p><p>qwddqdasdasdadsadqw</p><p>阿达萨达</p><p>无钱无权驱蚊器恶气恶趣味去</p>";
    [webView loadHTMLString:[self loadRichText:richText] baseURL:nil];
}

-(NSString *)loadRichText:(NSString *)richText {
    NSString *htmlPath = [NSBundle.mainBundle pathForResource:@"richH5.html" ofType:nil];
    NSString *htmlstring = [[NSString alloc] initWithContentsOfFile:htmlPath  encoding:NSUTF8StringEncoding error:nil];
    NSString *newHtml = [htmlstring stringByReplacingOccurrencesOfString:@"{bycc}" withString:richText];
    return newHtml;
}


@end
