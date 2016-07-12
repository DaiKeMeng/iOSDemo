//
//  ViewController.m
//  demo--进度条
//
//  Created by 代克孟 on 16/4/18.
//  Copyright © 2016年 代克孟. All rights reserved.
//

#import "ViewController.h"
#import "progressView.h"

@interface ViewController ()<progressViewDelegate>

@end

@implementation ViewController
#define UI_SCALE  [UIScreen mainScreen].bounds.size.width/750.0f

- (void)viewDidLoad {
    [super viewDidLoad];
    progressView* pView = [[progressView alloc] initWithFrame:CGRectMake(70 * UI_SCALE, 200, self.view.frame.size.width - 140 * UI_SCALE, 200)];
    pView.backgroundColor = [UIColor whiteColor];
    pView.delegate      = self;
    [self.view addSubview:pView];
}

-(void)returnTouchInViewSpace:(CGFloat)space
{
    NSLog(@"返回%.2f比例",space);
}


@end
