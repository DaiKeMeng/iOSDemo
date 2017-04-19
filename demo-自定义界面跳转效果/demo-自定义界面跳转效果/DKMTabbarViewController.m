//
//  DKMTabbarViewController.m
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/18.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "DKMTabbarViewController.h"
#import "DKMTransitionClass.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface DKMTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation DKMTabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    NSArray* viewControllers = @[[ViewController new],[SecondViewController new]];
    NSMutableArray* subViewControllers = [NSMutableArray array];
    for (int i = 0; i < viewControllers.count; i++) {
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewControllers[i]];
        [nav.tabBarItem setTitle:NSStringFromClass([viewControllers[i] class])];
        [subViewControllers addObject:nav];
    }
    self.viewControllers = subViewControllers;
    self.selectedIndex = 0;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    DKMTransitionClass* transition = [[DKMTransitionClass alloc] init];
    transition.isLeft = fromIndex > toIndex ? NO : YES;
    return transition;
}

@end
