//
//  WaitView.m
//  iOSTest
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "WaitView.h"

#define CONTENT_HEIGHT (60)
#define CONTENT_MARGIN (40)

@interface WaitView ()
@property (strong,nonatomic,readwrite) UILabel *label;
@property (strong,nonatomic,readwrite) UIActivityIndicatorView *indicator;
@end

@implementation WaitView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cancelable = YES;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
        bg.backgroundColor = RGBA(.0f, .0f, .0f, 102.0f);
        [self addSubview:bg];
        bg.userInteractionEnabled = YES;
        [bg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancle)] ];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, (SCREEN_HEIGHT-CONTENT_HEIGHT)/2, SCREEN_WIDTH - CONTENT_MARGIN, CONTENT_HEIGHT)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowRadius = 3.0f;
        view.layer.shadowOpacity = .8f;
        view.layer.shadowOffset = CGSizeMake(3, 3);
        view.layer.cornerRadius = 3.0f;
        [self addSubview:view];
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15.0f];
        self.label.text = DEFAULT_TITLE;
        [self.label sizeToFit];
        [view addSubview:self.label];
        self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, view.bounds.size.height/2, 0, 0)];
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.indicator startAnimating];
        [view addSubview:self.indicator];
        [self adjustContentSubView];
    }
    return self;
}

- (instancetype)initWithCancelBlock:(void(^)(void)) cancelBlock {
    self = [self init];
    if (self) {
        self.cancelBlock = cancelBlock;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*) title{
    self = [self init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*) title andcancelBlock:(void(^)(void)) cancelBlock {
    self = [self initWithTitle:title];
    if (self) {
        self.cancelBlock = cancelBlock;
    }
    return self;
}

#pragma mark private

- (void)adjustContentSubView{
    [self.label sizeToFit];
    int w = self.label.bounds.size.width + self.indicator.bounds.size.width;
    CGRect rect = self.indicator.frame;
    rect.origin.x = (SCREEN_WIDTH - CONTENT_MARGIN - w)/2;
    self.indicator.frame = rect;
    rect = self.label.frame;
    rect.origin.x = self.indicator.frame.origin.x + 20;
    rect.origin.y = (CONTENT_HEIGHT - self.label.bounds.size.height)/2;
    self.label.frame = rect;
}

- (void)cancle{
    if(_cancelable){
        if([self.delegete respondsToSelector:@selector(waitViewCancle)])
           [self.delegete waitViewCancle];
        else if(_cancelBlock)
            _cancelBlock();
        [self dismiss];
    }
}

#pragma mark public

- (void)setTitle:(NSString*) title{
    self.label.text = [NSString stringWithString:title];
    [self adjustContentSubView];
}

- (NSString*)title{
    return self.label.text;
}

- (void)show{
    if(!self.superview)
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
    self.alpha = .0f;

    [UIView animateWithDuration:.25f animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)showWidthTitle:(NSString*) title{
    self.title = title;
    [self show];
}

- (void)dismiss{
    if(self.superview)
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

- (BOOL)isShow{
    return self.superview != nil;
}

@end
