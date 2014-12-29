//
//  DeleteFamilyView.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "DeleteFamilyView.h"

@interface DeleteFamilyView ()<UIGestureRecognizerDelegate>

@end

@implementation DeleteFamilyView

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

+ (DeleteFamilyView*)instance
{
     return [[NSBundle mainBundle] loadNibNamed:@"DeleteFamilyView" owner:nil options:nil][0];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"DeleteFamilyView"]) {
        return YES;
    }
    return  NO;
}

- (IBAction)cancleClick:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)sureClick:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(deletFamilyMember)]) {
        [_delegate deletFamilyMember];
    }
     [self removeFromSuperview];
}
@end
