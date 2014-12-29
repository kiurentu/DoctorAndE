//
//  BackBtn.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-17.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "MyBarBtnItem.h"

@interface MyBarBtnItem ()
@property (weak, nonatomic) UIViewController *vc;
@end

@implementation MyBarBtnItem
- (instancetype)initWithImageName:(NSString *)imgName withTitle:(NSString *)title withTarget:(id)target withAction:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn setImage:IMAGE(imgName) forState:UIControlStateNormal];
    [btn setTitle:([title length] && imgName && [imgName length]?[NSString stringWithFormat:@" %@", title]:title) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateNormal];
    [btn sizeToFit];
    CGRect f = btn.frame;
    f.size.height = 44;
    btn.frame = f;
    [btn setImage:IMAGE(imgName) forState:UIControlStateNormal];
    [btn setBackgroundImage:[Tools createImageWithColor:RGBA(30, 30, 30, 100)] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self = [self initWithCustomView:btn];
    return self;
}

- (instancetype)initWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)action
{
    return [self initWithImageName:nil withTitle:title withTarget:target withAction:action];
}

- (instancetype)initDefaultClickBackWithImageName:(NSString*)imgName withTitle:(NSString *)title withViewController:(UIViewController *)vc
{
    self = [self initWithImageName:imgName withTitle:title withTarget:self withAction:@selector(defaultAction:)];
    self.vc = vc;
    return self;
}

/**
 *  默认按钮执行方法
 *
 *  @param sender 按钮
 */
- (void)defaultAction:(UIButton *)sender
{
    if (self.vc.navigationController) {
        [self.vc.navigationController popViewControllerAnimated:YES];
    } else {
        [self.vc dismissViewControllerAnimated:YES completion:nil];
    }
}

@end