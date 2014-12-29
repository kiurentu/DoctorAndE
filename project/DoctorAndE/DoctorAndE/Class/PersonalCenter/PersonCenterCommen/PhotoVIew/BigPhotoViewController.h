//
//  BigPhotoViewController.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property(weak,nonatomic) UIImage *bigImage;

@end
