//
//  firstViewController.m
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/17.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "firstViewController.h"
#import "DKMTransitionClass.h"

#import "SecondViewController.h"
#import "ViewController.h"

@interface firstViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation firstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // 在创建的时候一定要遵守动画过程类的协议
    self.transitioningDelegate = self;
}

//  重写present 和 dismiss的方法。
//  返回遵守UIViewControllerAnimatedTransitioning协议的实体类
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if ([source isKindOfClass:[ViewController class]]) {
        NSLog(@"ViewController");
    }
    if ([presenting isKindOfClass:[ViewController class]]) {
        NSLog(@"SecondViewController");
    }
    DKMTransitionClass* dkmtranC = [[DKMTransitionClass alloc] init];
    dkmtranC.isLeft              = YES;
    return dkmtranC;
}

//  返回遵守UIViewControllerAnimatedTransitioning协议的实体类
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DKMTransitionClass* dkmtranC = [[DKMTransitionClass alloc] init];
    dkmtranC.isLeft              = NO;
    return dkmtranC;
}

@end
