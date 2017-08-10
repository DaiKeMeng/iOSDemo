//
//  ViewController.m
//  DKMWebImage
//
//  Created by 代克孟 on 2017/8/10.
//  Copyright © 2017年 代克孟. All rights reserved.
//
/**
  简单的完成SDWebImage的实现原理
  1 创建一个单利，保存所有的实图和地址
  2 分类UIImageView的实现方法，然后添加实现网络加载图片的自定义方法
  3 分类中进行网络请求
 **/

#import "ViewController.h"
#import "UIImageView+DKMImageView1.h"
#import "DKMWebImage.h"

@interface ViewController ()
@property (nonatomic ,strong) UIImageView* imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"地址1:%@",[DKMWebImage shared]);
    NSLog(@"地址2:%@",[[DKMWebImage alloc] init]);
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    [self.imageView setImageWithUrl:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2985792356,1844942587&fm=11&gp=0.jpg"] andDefaultImage:[UIImage imageNamed:@"12"]];
    [self.view addSubview:self.imageView];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 40)];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 0;
    [self.view addSubview:btn];
}

-(void)addImageViewAction:(UIButton*)sender
{
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50 + sender.tag * 80, 400, 80, 80)];
    [imageView setImageWithUrl:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2985792356,1844942587&fm=11&gp=0.jpg"] andDefaultImage:[UIImage imageNamed:@"12"]];
    [self.view addSubview:imageView];
    sender.tag += 1;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
