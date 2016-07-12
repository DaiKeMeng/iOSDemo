//
//  progressView.m
//  demo--进度条
//
//  Created by 代克孟 on 16/4/18.
//  Copyright © 2016年 代克孟. All rights reserved.
//

#import "progressView.h"

#define UI_SCALE  [UIScreen mainScreen].bounds.size.width/750.0f
@implementation progressView
{
    // 120度对应的圆周角
    CGFloat diameter;
    // 半径
    CGFloat radius;
    // 起点y值
    CGFloat sPointY;
    CGFloat touchX;
    CAShapeLayer* layer ,*layer1;
    BOOL isBegin;
    CGFloat saveStatusX;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        diameter = frame.size.width ;
        radius   = diameter / sqrt(3);
        sPointY  = radius * 0.5;
        touchX   = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(diameter * 0.5, radius) radius:radius startAngle:(M_PI * 7 / 6) endAngle:( M_PI * 11 / 6) clockwise:YES];
    path.lineCapStyle   = kCGLineCapRound;
    path.lineJoinStyle  = kCGLineJoinRound;
    layer               = [CAShapeLayer layer];
    layer.path          = path.CGPath;
    layer.lineWidth     = 26 * UI_SCALE;
    layer.lineCap       = @"round";
    
    [layer setStrokeColor:[UIColor colorWithRed:0.449 green:0.424 blue:0.429 alpha:1.000].CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    [self.layer addSublayer:layer];
    
    if (isBegin) {
        UIBezierPath* path1 = [UIBezierPath bezierPath];
        [path1 addArcWithCenter:CGPointMake( diameter * 0.5, radius) radius:radius startAngle:(M_PI * 7 / 6) endAngle:(M_PI * 7 / 6 + 2 * M_PI / 3 * (touchX / diameter)) clockwise:YES];
        path1.lineCapStyle  = kCGLineCapRound;
        
        layer1              = [CAShapeLayer layer];
        layer1.path         = path1.CGPath;
        layer1.lineWidth    = 10 * UI_SCALE;
        layer1.lineCap       = @"round";
        [layer1 setStrokeColor:[UIColor colorWithRed:0.927 green:0.012 blue:0.097 alpha:1.000].CGColor];
        [layer1 setFillColor:[UIColor clearColor].CGColor];
        [self.layer addSublayer:layer1];
    }
}

// 点击上去
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint p   = [[touches anyObject] locationInView:self];
    touchX      = p.x;
    if (touchX <= saveStatusX + 40 &&touchX >= saveStatusX - 40) {
        isBegin = YES;
    }else{
        isBegin = NO;
        return;
    }
    if (touchX <= 0) {
        touchX  = 0;
    }else{
        if (touchX > diameter ) {
            touchX = diameter;
        }
    }
    [self.delegate returnTouchInViewSpace:(touchX / diameter)];
    [layer removeFromSuperlayer];
    [layer1 removeFromSuperlayer];
    [self setNeedsDisplay];
}

// 手指移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isBegin == NO) {
        return;
    }
    CGPoint p   = [[touches anyObject] locationInView:self];
    touchX      = p.x;
    if (touchX  <= 0) {
        touchX  = 0;
    }else{
        if (touchX > diameter ) {
            touchX = diameter;
        }
    }
    [self.delegate returnTouchInViewSpace:(touchX / diameter)];
    [layer removeFromSuperlayer];
    [layer1 removeFromSuperlayer];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (isBegin) {
        saveStatusX = touchX ;
    }
}


@end
