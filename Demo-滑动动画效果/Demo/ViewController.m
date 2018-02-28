//
//  ViewController.m
//  Demo
//
//  Created by 代克孟 on 2018/2/27.
//  Copyright © 2018年 代克孟. All rights reserved.
//

#import "ViewController.h"

// 最多的btn个数
static NSInteger btn_max_count  = 5;
// 一页最多放的btn个数
static NSInteger count          = 4;
//static CGFloat   kMax_Width     = 80;

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView*     conScrollView;      // 内容scrollview
@property (nonatomic ,assign) CGFloat           kWidth;             // 全局长
@property (nonatomic ,assign) CGFloat           kHeight;            // 全局宽
@property (nonatomic ,strong) NSMutableArray*   btnArray;           // btn的数组
@property (nonatomic ,assign) NSInteger         selectedTag;        // 选择的控件
@property (nonatomic ,assign) CGFloat           btn_width;          // btn的宽
@property (nonatomic ,strong) UIView*           lineView;           // 滑动的横线
@property (nonatomic ,assign) BOOL              isDragging;         // 是否拖拽的滑动

@end

@implementation ViewController
{
    CGPoint beforeCenter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _kWidth         = self.view.frame.size.width;
    _kHeight        = self.view.frame.size.height;
    _btnArray       = [NSMutableArray array];
    _selectedTag    = 0;
    [self setUpTopScrollView];
    [self setUpContentViewAction];
}

-(void)setUpTopScrollView{
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _kWidth, 90)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _btn_width       = _kWidth / count;
    CGFloat btn_height      = 90;
    for (int i = 0; i < btn_max_count; ++i) {
        UIButton* btn       = [[UIButton alloc] initWithFrame:CGRectMake(i * _btn_width, 0, _btn_width, btn_height)];
        [btn setTitle:@"测试" forState:UIControlStateNormal];
        [btn setTag:i];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        if (0 == i) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(jumpToTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
        [_btnArray addObject:btn];
    }
    [scrollView setContentSize:CGSizeMake(_btn_width * btn_max_count, 0)];
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 3)];
    _lineView.backgroundColor = [UIColor redColor];
    _lineView.center          = CGPointMake(_btn_width * 0.5, 80);
    [scrollView addSubview:_lineView];
}
// 跳转方法
-(void)jumpToTitleAction:(UIButton*)sender{
    if (_selectedTag == sender.tag) {
        return;
    }
    sender.selected     = YES;
    CGFloat space = (sender.tag - _selectedTag) * _btn_width;
    _selectedTag        = sender.tag;
    for (int i = 0; i < _btnArray.count; ++i) {
        if (_selectedTag != i) {
            UIButton* btn = _btnArray[i];
            btn.selected  = NO;
        }
    }
    beforeCenter = _lineView.center;
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frameOfLineView      = _lineView.frame;
        frameOfLineView.size.width  = _btn_width - 20;
        _lineView.frame             = frameOfLineView;
        _lineView.center            = CGPointMake(beforeCenter.x + space * 0.5, 80);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect frameOfLineView      = _lineView.frame;
            frameOfLineView.size.width  = 30;
            _lineView.frame             = frameOfLineView;
            _lineView.center            = CGPointMake(beforeCenter.x + space, 80);
        } completion:^(BOOL finished) {

        }];
    }];
    [_conScrollView setContentOffset:CGPointMake(_kWidth * _selectedTag, 0) animated:YES];
}

-(void)setUpContentViewAction
{
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, _kWidth, _kHeight - 90)];
    scrollView.delegate      = self;
    scrollView.contentSize   = CGSizeMake(_kWidth * btn_max_count, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.conScrollView       = scrollView;
    for (int i = 0; i < btn_max_count; ++i) {
        UIView* subView       = [[UIView alloc] initWithFrame:CGRectMake(i * _kWidth, 0, _kWidth, _kHeight - 90)];
        subView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.15 * i];
        [self.conScrollView addSubview:subView];
    }
}

#pragma UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_isDragging) {
        CGFloat space =scrollView.contentOffset.x -  _selectedTag * _kWidth;
        NSLog(@"scrollViewDidScroll : %f  _selectedTag : %d   space : %f",scrollView.contentOffset.x,_selectedTag,space);
        CGRect frameOfLineView      = _lineView.frame;
        if (ABS(space) <= _kWidth * 0.8) {
            frameOfLineView.size.width  = 30 + (_btn_width - 50) * (ABS(space) / (_kWidth * 0.8));
            _lineView.frame             = frameOfLineView;
            _lineView.center            = CGPointMake(beforeCenter.x + space/(_kWidth * 0.8) * _btn_width * 0.5, 80);
        }else{
            frameOfLineView.size.width  = _btn_width - 20 - (_btn_width - 50) * (5* ABS(space) / _kWidth - 4);
            _lineView.frame             = frameOfLineView;
            if (space > 0) {
                _lineView.center            = CGPointMake(beforeCenter.x + (2.5* space / _kWidth - 1.5) * _btn_width, 80);
            }else{
                _lineView.center            = CGPointMake(beforeCenter.x - (2.5* ABS(space) / _kWidth - 1.5) * _btn_width, 80);
            }
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beforeCenter = _lineView.center;
    _isDragging = YES;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDragging = NO;
    CGFloat scrollView_X = scrollView.contentOffset.x;
    if (_selectedTag == scrollView_X / _kWidth) {
        return;
    }
    _selectedTag        = scrollView_X / _kWidth;
    for (int i = 0; i < _btnArray.count; ++i) {
        UIButton* btn = _btnArray[i];
        if (_selectedTag != i) {
            btn.selected  = NO;
        }else{
            btn.selected  = YES;
        }
    }
    [_conScrollView setContentOffset:CGPointMake(_kWidth * _selectedTag, 0) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
