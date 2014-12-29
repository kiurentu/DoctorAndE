//
//  FFScrollView.h
//  CGcircle
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 com.gk.SmartGit. All rights reserved.
//
/**
 *  图片轮播类
 *
 *  @param instancetype initPageViewWithFrame
 *
 */

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "UIImageView+WebCache.h"
typedef enum
{
    FFScrollViewSelecttionTypeTap = 100,  //默认的为可点击模式
    FFScrollViewSelecttionTypeNone   //不可点击的
}FFScrollViewSelecttionType;

@protocol FFScrollViewDelegate <NSObject>

@optional
- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber;

@end

@interface FFScrollView : UIView <UIScrollViewDelegate>
{
    NSTimer *_timer;
    NSArray *_imageArr;
}

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIPageControl *pageControl;

@property(assign, nonatomic) FFScrollViewSelecttionType selectionType;
@property(assign, nonatomic) id <FFScrollViewDelegate> pageViewDelegate;


-(void)PageViewWithInformationArray:(NSArray *)imageArr;

@end
