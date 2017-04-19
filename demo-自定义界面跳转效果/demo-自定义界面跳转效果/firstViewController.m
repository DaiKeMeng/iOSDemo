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
    self.transitioningDelegate = self;
}

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

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([dismissed isKindOfClass:[SecondViewController class]]) {
        NSLog(@"返回第一个页面");
    }
    DKMTransitionClass* dkmtranC = [[DKMTransitionClass alloc] init];
    dkmtranC.isLeft              = NO;
    return dkmtranC;
}

@end
