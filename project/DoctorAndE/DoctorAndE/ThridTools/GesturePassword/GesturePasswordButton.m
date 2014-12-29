//
//  GesturePasswordButton.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import "GesturePasswordButton.h"

#define bounds self.bounds

@implementation GesturePasswordButton
@synthesize selected;
@synthesize success;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        success = YES;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (selected) {
        if (success) {
            CGContextSetRGBStrokeColor(context, 20/255.0f,166/255.0f,116/255.0f,1.0f);//线条颜色
            CGContextSetRGBFillColor(context,238/255.f, 139/255.f, 21/255.f,1);
        }else {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f,1);//线条颜色
            CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,1);
        }
        CGRect frame = CGRectMake(bounds.size.width/2-bounds.size.width/8+1, bounds.size.height/2-bounds.size.height/8, bounds.size.width/4, bounds.size.height/4);
        
        CGContextAddEllipseInRect(context,frame);
        CGContextFillPath(context);
    }else{
        CGContextSetRGBStrokeColor(context, 115/255.0f,114/255.0f,112/255.0f,1.0f);//线条颜色
    }
    
    CGContextSetLineWidth(context,2);
    CGRect frame = CGRectMake(2, 2, bounds.size.width-3, bounds.size.height-3);
    CGContextAddEllipseInRect(context,frame);
    CGContextStrokePath(context);
    if (success) {
        CGContextSetRGBFillColor(context,30/255.f, 175/255.f, 235/255.f,.0f);
    }else {
        CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,0.3);
    }
    CGContextAddEllipseInRect(context,frame);
    if (selected) {
        CGContextFillPath(context);
    }
    
}


@end
