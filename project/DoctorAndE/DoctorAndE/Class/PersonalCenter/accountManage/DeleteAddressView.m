//
//  DeleteAddressView.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-8.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "DeleteAddressView.h"

@interface DeleteAddressView ()<UIGestureRecognizerDelegate>

@end

@implementation DeleteAddressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.55];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleClick:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

+ (DeleteAddressView*)instance
{
     return [[NSBundle mainBundle] loadNibNamed:@"DeleteAddressView" owner:nil options:nil][0];
}

- (IBAction)cancleClick:(id)sender
{
    [self removeFromSuperview];
}
- (IBAction)sureClick:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(deletAddress:)]) {
        [_delegate deletAddress:_obj];
    }
    [self removeFromSuperview];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    //    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"DeleteAddressView"]) {
        return YES;
    }
    return  NO;
}
@end
