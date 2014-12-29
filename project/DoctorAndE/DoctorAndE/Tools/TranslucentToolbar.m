//
//  TranslucentToolbar.m
//  DoctorAndE
//
//  Created by SmartGit on 14-11-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "TranslucentToolbar.h"

@implementation TranslucentToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];  //设置为背景透明，可以在这里设置背景图片
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
