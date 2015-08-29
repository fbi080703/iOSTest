//
//  ViewController.m
//  SocialSharing
//
//  Created by Apple on 15/6/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "UMSocial.h"

@interface ViewController () <UMSocialUIDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button= [[UIButton alloc] init];
    button.frame=CGRectMake(100, 100, 100,100);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor brownColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonClick:(UIButton *)btn
{
    //[UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5573caa067e58e29f10075db"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
}

@end
