//
//  DKMTransitionClass.m
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/17.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "DKMTransitionClass.h"

@implementation DKMTransitionClass

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toVC      = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    CGRect finalRect            = [transitionContext finalFrameForViewController:toVC];
    UIView* toV                 = [toVC view];
    UIView* contantView         = [transitionContext containerView];
   
    toV.frame                   = CGRectOffset(finalRect,self.isLeft == YES ? [UIScreen mainScreen].bounds.size.width : -[UIScreen mainScreen].bounds.size.width, 0);
    [contantView addSubview:toV];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toV.frame = finalRect;
    } completion:^(BOOL finished) {
         [transitionContext completeTransition:YES];
    }];
}
@end
