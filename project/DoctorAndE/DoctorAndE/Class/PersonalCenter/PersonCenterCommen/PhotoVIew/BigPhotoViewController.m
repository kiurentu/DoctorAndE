//
//  BigPhotoViewController.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "BigPhotoViewController.h"

@interface BigPhotoViewController ()<UIScrollViewDelegate>

@end

@implementation BigPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"查看图片" withViewController:self];
    
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    _scrollView.contentSize =self.bigImageView.image.size;
    self.bigImageView.image = _bigImage;

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.bigImageView;
}

-(void)setBigImage:(UIImage *)bigImage{
    _bigImage = bigImage;
    
}
@end
