//
//  LoopView.m
//  CustomLoopView
//
//  Created by qianfeng on 15-9-10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LoopView.h"

@interface LoopView()<UIScrollViewDelegate>



@end


@implementation LoopView


{
    UIScrollView * _scrollView;
    UIImageView *  _leftImageView;
    UIImageView *  _currentImageView;
    UIImageView *  _rightImageView;
    
    NSInteger     _currentIndex;
    
    //   添加页码指示器
    
    UIPageControl * _pageControl;
    
    NSTimer * _timer;
    
}


+ (instancetype) customLoopViewWithframe:(CGRect)frame AndView:(UIView *)SuperView AndImageArray:(NSArray *)imageArray

{
    
    LoopView *loopView = [[LoopView alloc]initWithFrame:frame AndImageArray:imageArray];
    [SuperView addSubview:loopView];
    
    return loopView;
    
}

- (instancetype)initWithFrame:(CGRect)frame AndImageArray:(NSArray *)imageArray

{
    if (self = [super initWithFrame:frame])
    {
        self.imageArray = imageArray;
        _currentIndex = 0;
        [self creatScrollView];
        
    }
    return self;
}
//   创建滚动视图  --   scrollView

- (void)creatScrollView
{
    //   创建滚动视图
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    [self addSubview:_scrollView];
    
    /**
     *  创建页码指示器
     */
    
    _pageControl = [[UIPageControl alloc]init];
    
    CGFloat x = (self.frame.size.width - 100)/2;
    CGFloat y = self.frame.size.height - 50;
    CGFloat w = 100;
    CGFloat h = 30;
    
    _pageControl.frame = CGRectMake(x, y, w, h);
    _pageControl.numberOfPages = self.imageArray.count;
    _pageControl.pageIndicatorTintColor = [UIColor blueColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addSubview:_pageControl];
    
    
    /**
     *  创建三个ImageView 实现scrollView的复用
     */
    
    _leftImageView = [[UIImageView alloc]init];
    _leftImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _currentImageView = [[UIImageView alloc]init];
    _currentImageView.frame = CGRectMake( self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    
    _rightImageView = [[UIImageView alloc]init];
    _rightImageView.frame = CGRectMake(self.frame.size.width*2, 0,self.frame.size.width, self.frame.size.height);
    
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_currentImageView];
    [_scrollView addSubview:_rightImageView];
    
    
    [self reloadImage];
    [self startTimer];
    
}

// 定时器

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
    
}

- (void)scrollAction
{
    [UIView animateWithDuration:1 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * 2, 0);
    }];
    
    
    _currentIndex = _currentIndex+1==self.imageArray.count ? 0 :_currentIndex+1;
    
    [self reloadImage];
    _pageControl.currentPage = _currentIndex;
    
    
    
    
}


- (void)reloadImage
{
    //   先移除三张图片
    
    _leftImageView.image    = nil;
    _currentImageView.image = nil;
    _rightImageView.image   = nil;
    
    _currentImageView.image = [UIImage imageNamed:self.imageArray[_currentIndex]];
    _leftImageView.image    = [UIImage imageNamed:(_currentIndex - 1)<0 ? [self.imageArray lastObject] :self.imageArray[_currentIndex - 1]];
    
    _rightImageView.image   = [UIImage imageNamed:_currentIndex+1 == self.imageArray.count ? self.imageArray[0] : self.imageArray[_currentIndex + 1]];
    
    
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
    
}

#pragma mark ------- 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
    
}


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    NSInteger index = _scrollView.contentOffset.x/_scrollView.frame.size.width;
    if (index == 0) {
        
        _currentIndex = (_currentIndex -1)<0 ? self.imageArray.count - 1: _currentIndex - 1;
        
        [self reloadImage];
    }
    
    if (index == 2) {
        _currentIndex = _currentIndex+1==self.imageArray.count ? 0 :_currentIndex+1;
        
        [self reloadImage];
    }
    
    _pageControl.currentPage = _currentIndex;
    
    
    
}

@end
