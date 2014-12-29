//
//  CircleEdge.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import "CircleEdge.h"

@implementation CircleEdge

+(void)changView:(UIView *)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3.5;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [RGBCOLOR(181, 181, 181) CGColor];

}

@end
