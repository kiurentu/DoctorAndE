//
//  PhotoView.h
//  DoctorAndE
//
//  Created by UI08 on 14-11-26.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoViewDelegate<NSObject>

-(void)choosePhotoImage:(UIImage *)image;


@end


@interface PhotoView : UIView

@property(nonatomic,weak)id<PhotoViewDelegate>delegate;//使用代理传值

+ (PhotoView*)instance;

-(instancetype)initWithViewController:(UIViewController *)ViewController withImageArr:(NSMutableArray *)imageArr;

- (IBAction)takePhotoClick:(id)sender;
- (IBAction)choosePhotoClick:(id)sender;

@end
