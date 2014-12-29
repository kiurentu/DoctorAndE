//
//  UIButton+Bg.m
//  MJ微博demo
//
//  Created by kang on 14-10-3.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "UIButton+Bg.h"

@implementation UIButton (Bg)

//设置按钮所有状态下的背景
-(CGSize)setAllStateBg:(NSString *)icon{
    
    UIImage *normal = [UIImage stretchImaheWithName:icon];
    UIImage *highlight = [UIImage stretchImaheWithName:[icon fileNameAppend:@"_highlighted"]];
    
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlight forState:UIControlStateHighlighted];
    
    return normal.size;
    
    
}


@end
