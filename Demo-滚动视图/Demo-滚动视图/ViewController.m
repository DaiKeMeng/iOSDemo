//
//  ViewController.m
//  Demo-滚动视图
//
//  Created by 代克孟 on 2017/8/8.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "ViewController.h"
#import "DKMScrollVIew.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DKMScrollVIew * scrollView = [[DKMScrollVIew alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400) andSource:nil];
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
