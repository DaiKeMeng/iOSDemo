//
//  DKMScrollVIew.m
//  Demo-滚动视图
//
//  Created by 代克孟 on 2017/8/8.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "DKMScrollVIew.h"
@interface DKMScrollVIew ()<UIScrollViewDelegate>
@property (nonatomic ,strong) NSMutableArray<UIImage*>*images;
@property (nonatomic ,strong) UIScrollView*  scrollView;
// 第一个试图
@property (nonatomic ,strong) UIImageView*   firstImgV;
// 第二个试图
@property (nonatomic ,strong) UIImageView*   secondImgV;
@property (nonatomic ,assign) NSInteger      currentIndex;

@property (nonatomic ,assign) CGPoint        scrollViewOffPoint;
@property (nonatomic ,strong) UIPageControl* pageControl;
@property (nonatomic ,strong) NSTimer*       timer;

@end

@implementation DKMScrollVIew

-(instancetype)initWithFrame:(CGRect)frame andSource:(NSArray*)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = [NSMutableArray array];
        for (int i = 1; i < 5; ++i) {
            UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"timg-%d",i]];
            [self.images addObject:image];
        }
        [self setUpContentViewAction];
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(resetScrollViewOffSetAction) userInfo:nil repeats:YES];
    
        self.timer = timer;
    }
    return self;
}

-(void)resetScrollViewOffSetAction
{
    if (self.secondImgV == nil) {
        self.secondImgV  = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
        NSInteger index = self.currentIndex;
        if (self.currentIndex == 0) {
            index = self.images.count - 1;
        }else{
            index = self.currentIndex - 1;
        }
        self.secondImgV.image = self.images[index];
        [self.scrollView addSubview:self.secondImgV];
    }
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
    
}

// 创建内容实图
-(void)setUpContentViewAction
{
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.delegate      = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize   = CGSizeMake(self.frame.size.width * 3, 0);
    scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    self.currentIndex = 0;
    self.firstImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    self.firstImgV.image = self.images[0];
    [self.scrollView addSubview:self.firstImgV];
    UIPageControl* pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    CGSize size                = [pageControl sizeForNumberOfPages:self.images.count];
    pageControl.frame          = CGRectMake(0, 0, size.width, size.height);
    pageControl.center         = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height - 50);
    pageControl.numberOfPages = self.images.count;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
// 当视图不在滚动时
/** 分情况考虑
 1 确实是翻页了             这种情况下要进行
 2 没有翻页，返回回来
 **/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x - self.frame.size.width > 0) {
        if (self.secondImgV == nil) {
            self.secondImgV  = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
            NSInteger index = self.currentIndex;
            if (self.currentIndex == 0) {
                index = self.images.count - 1;
            }else{
                index = self.currentIndex - 1;
            }
            self.secondImgV.image = self.images[index];
            [self.scrollView addSubview:self.secondImgV];
        }
    }else if (scrollView.contentOffset.x - self.frame.size.width < 0){
        if (self.secondImgV == nil) {
            self.secondImgV  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            NSInteger index = self.currentIndex;
            if (self.currentIndex == self.images.count - 1) {
                index = 0;
            }else{
                index = self.currentIndex + 1;
            }
            self.secondImgV.image = self.images[index];
            [self.scrollView addSubview:self.secondImgV];
        }
    }else{
        // 此时没有任何
        [self.secondImgV removeFromSuperview];
        self.secondImgV = nil;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    self.scrollViewOffPoint = scrollView.contentOffset;
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    [self.timer setFireDate:[NSDate distantPast]];
    if (self.scrollViewOffPoint.x == scrollView.contentOffset.x) {
        [self.secondImgV removeFromSuperview];
        self.secondImgV = nil;
    }else if (self.scrollViewOffPoint.x > scrollView.contentOffset.x){
        // 此时向左偏移了width个单位
        self.firstImgV.image = self.secondImgV.image;
        [self.secondImgV removeFromSuperview];
        self.secondImgV = nil;
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        if (self.currentIndex == 0) {
            self.currentIndex = self.images.count - 1;
        }else{
            self.currentIndex -= 1;
        }
        self.pageControl.currentPage = self.currentIndex;
    }else{
        // 此时向右偏移了width个单位
        self.firstImgV.image = self.secondImgV.image;
        [self.secondImgV removeFromSuperview];
        self.secondImgV = nil;
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        if (self.currentIndex == self.images.count - 1) {
            self.currentIndex = 0;
        }else{
            self.currentIndex += 1;
        }
        self.pageControl.currentPage = self.currentIndex;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
    self.firstImgV.image = self.secondImgV.image;
    [self.secondImgV removeFromSuperview];
    self.secondImgV = nil;
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    if (self.currentIndex == self.images.count - 1) {
        self.currentIndex = 0;
    }else{
        self.currentIndex += 1;
    }
    self.pageControl.currentPage = self.currentIndex;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
