//
//  FFScrollView.m
//  CGcircle
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 com.gk.SmartGit. All rights reserved.
//

#import "FFScrollView.h"
#import "UIImageView+WebCache.h"

@implementation FFScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

-(void)PageViewWithInformationArray:(NSArray *)imageArr{
    
    self.selectionType = FFScrollViewSelecttionTypeTap;
    _imageArr = imageArr;
    
    [self iniSubviewsWithFrame];
}


-(void)iniSubviewsWithFrame
{
    CGRect frame = self.frame;
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGRect fitRect = CGRectMake(0, 0, width, height);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:fitRect];
    self.userInteractionEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(width*(_imageArr.count+2), height);
    //隐藏上下滚动条
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    if (_imageArr) {
        //后面添加一张
        UIImageView *firstImageView = [[UIImageView alloc]initWithFrame:fitRect];
        [firstImageView sd_setImageWithURL:[_imageArr lastObject]];
//        firstImageView.image = [_imageArr lastObject];
        [self.scrollView addSubview:firstImageView];
        
        for (int i = 0; i < _imageArr.count; i++) {
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(width*(i+1), 0, width, height)];
//            imageview.image = [_imageArr objectAtIndex:i];
            [imageview sd_setImageWithURL:[_imageArr objectAtIndex:i]];
            [self.scrollView addSubview:imageview];
        }
        //前面添加一张
        UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width*(_imageArr.count+1), 0, width, height)];
//        lastImageView.image = [_imageArr firstObject];
        [lastImageView sd_setImageWithURL:[_imageArr firstObject]];
        [self.scrollView addSubview:lastImageView];
    }


    //pageControl
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, frame.size.height-20, 120, 20)];
//    self.pageControl.backgroundColor = [UIColor redColor];
    self.pageControl.numberOfPages = _imageArr.count;
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = YES;
    [self addSubview:self.pageControl];
    
    
    //UIScrollView偏移一张照片
    [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    
    //点击图片手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
}

#pragma mark --- 滚动手势
//自动滚动到下一页
-(IBAction)nextPage:(id)sender
{

    CGFloat pageWidth = self.scrollView.frame.size.width;
    int currentPage = self.scrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = _imageArr.count-1;
    }
    else if (currentPage == _imageArr.count+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
    
    currPageNumber++;
    if (currPageNumber == _imageArr.count) {
        CGRect newRect=CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [self.scrollView scrollRectToVisible:newRect animated:NO];
        currPageNumber = 0;
    }
    self.pageControl.currentPage = currPageNumber;
    

}

//点击图片的时候 触发
- (void)singleTap:(UITapGestureRecognizer *)tapGesture
{
    if (self.selectionType != FFScrollViewSelecttionTypeTap) {
        return;
    }
    if (self.pageViewDelegate && [self.pageViewDelegate respondsToSelector:@selector(scrollViewDidClickedAtPage:)]) {
        [self.pageViewDelegate scrollViewDidClickedAtPage:self.pageControl.currentPage];

    }
}

#pragma mark -- FFScrollViewDelegate
- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber{
    NSLog(@"测试");
}

#pragma mark -- UIScrollView delegate methods
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖动scrollview的时候 停止计时器控制的跳转
    [_timer invalidate];
    _timer = nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat heigth = self.scrollView.frame.size.height;
    //当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    int currentPage = self.scrollView.contentOffset.x/width;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(width*_imageArr.count, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = _imageArr.count-1;
    }
    else if (currentPage == _imageArr.count+1) {
        [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    //拖动完毕的时候 重新开始计时器控制跳转
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
}

@end
