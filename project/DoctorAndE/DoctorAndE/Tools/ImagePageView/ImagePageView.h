//
//  ImagePageView.h
//  ImagePageView
//
//  Created by skytoup on 14-12-26.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePageView : UIView
@property (assign, nonatomic) NSUInteger curP;
@property (strong, nonatomic) NSArray *imgUrls;

+ (ImagePageView*)instacenView;
@end
