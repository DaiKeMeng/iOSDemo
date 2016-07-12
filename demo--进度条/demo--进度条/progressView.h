//
//  progressView.h
//  demo--进度条
//
//  Created by 代克孟 on 16/4/18.
//  Copyright © 2016年 代克孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol progressViewDelegate <NSObject>

-(void)returnTouchInViewSpace:(CGFloat)space;

@end

@interface progressView : UIView
@property (nonatomic ,weak) id <progressViewDelegate>delegate;



@end
