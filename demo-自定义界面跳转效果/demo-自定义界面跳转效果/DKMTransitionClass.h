//
//  DKMTransitionClass.h
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/17.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKMTransitionClass : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic ,assign) BOOL isLeft;

@end
