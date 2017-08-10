//
//  DKMTransitionClass.m
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/17.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "DKMTransitionClass.h"

@implementation DKMTransitionClass

// 动画切换的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}
// 动画的过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 拿取将要切换的VC
    UIViewController* toVC      = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    // 拿取将要切换的VC的界面相对于窗口的位置和大小
    CGRect finalRect            = [transitionContext finalFrameForViewController:toVC];
    // 将要切换的VC的界面
    UIView* toV                 = [toVC view];
    // 拿取参照物，我的理解就是窗口
    UIView* contantView         = [transitionContext containerView];
    
    // 开始设置将要切换的View的起始位置
    toV.frame                   = CGRectOffset(finalRect,self.isLeft == YES ? [UIScreen mainScreen].bounds.size.width : -[UIScreen mainScreen].bounds.size.width, 0);
    // 把界面添加到窗口
    [contantView addSubview:toV];
    // 执行动画，展示界面的起始位置到最终位置的变化过程
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toV.frame = finalRect;
    } completion:^(BOOL finished) {
        // 告诉协议完成了动画
         [transitionContext completeTransition:YES];
    }];
}
@end
