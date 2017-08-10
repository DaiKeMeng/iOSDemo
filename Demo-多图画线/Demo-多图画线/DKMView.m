//
//  DKMView.m
//  Demo-多图画线
//
//  Created by 代克孟 on 2017/8/9.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "DKMView.h"
@implementation DKMView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.finishedLines   = [NSMutableArray array];
        self.linesInProgress = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor lightGrayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

-(void)strokeLine:(DKMLineView*)line
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    [path moveToPoint:line.beginP];
    [path addLineToPoint:line.endP];
    [path stroke];
}

/**
 1 touches就是手指在界面上的集合，有多少个手指就有多少个touch
 2
 **/

// 手指开始点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches) {
        CGPoint location = [t locationInView:self];
        DKMLineView* line = [[DKMLineView alloc] init];
        line.beginP = location;
        line.endP = location;
        // 获取对象指针
        // 然后指针作为key，line作为value存进可变字典里面
        // 同一个手指在上面移动的时候，UITouch对象的地址信息是不会改变的
        // 从而保证了key值的确定性
        NSValue* key              = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    [self setNeedsDisplay];
}
// 手指开始移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches) {
        NSValue* key = [NSValue valueWithNonretainedObject:t];
        DKMLineView* line = self.linesInProgress[key];
        line.endP = [t locationInView:self];
    }
//    UITouch* t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    self.currentLine.endP = location;
    [self setNeedsDisplay];
}
// 手指离开界面
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches) {
        NSValue* value = [NSValue valueWithNonretainedObject:t];
        DKMLineView* line = self.linesInProgress[value];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:value];
    }
//    [self.finishedLines addObject:self.currentLine];
//    self.currentLine = nil;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIColor blackColor] set];
    for (DKMLineView * line in self.finishedLines) {
        [self strokeLine:line];
    }
    [[UIColor redColor] set];
    for (NSValue* key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
//    if (self.currentLine) {
//        [[UIColor redColor] set];
//        [self strokeLine:self.currentLine];
//    }
}


@end
