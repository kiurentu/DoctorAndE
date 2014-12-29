//
//  GesturePasswordView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import "GesturePasswordView.h"
#import "GesturePasswordButton.h"
#import "TentacleView.h"

@implementation GesturePasswordView {
    NSMutableArray *buttonArray;

    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
}
@synthesize imgView;
@synthesize forgetButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;

- (id)initWithFrame:(CGRect)frame andType:(NSInteger) GesturePasswordType
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code
        self.backgroundColor = kGlobalBg; // 背景颜色
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0]; // 画密码的按钮组

        int gw = SCREEN_WIDTH;
        int gh = SCREEN_HEIGHT - (GesturePasswordType?(50+105):(44 + 60 + 105));
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 160, (frame.size.height - 105 - 60)/2 - gh/2 + 105 + (GesturePasswordType?35:0), gw, gh)];
        for (int i = 0; i < 9; i++) {
            NSInteger   row = i / 3;
            NSInteger   col = i % 3;
            // Button Frame

            NSInteger               distance = (gh/3 > gw/3 ? gw/3 : gh/3);
            NSInteger               size = distance / 1.5f;
            NSInteger               margin = (SCREEN_WIDTH - distance * 2 - size ) / 2;
            GesturePasswordButton   *gesturePasswordButton = [[GesturePasswordButton alloc]initWithFrame:CGRectMake(col * distance + margin, row * distance, size, size)];
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
        }

        frame.origin.y = 0;
        [self addSubview:view];
        tentacleView = [[TentacleView alloc] initWithFrame:view.frame];
        [tentacleView setButtonArray:buttonArray];
        [tentacleView setTouchBeginDelegate:self];
        [self addSubview:tentacleView];

        state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 140, view.frame.origin.y - 35 , 280, 30)];
        [state setTextAlignment:NSTextAlignmentCenter];
        [state setFont:[UIFont systemFontOfSize:14.f]];
        state.backgroundColor = [UIColor clearColor];
        [self addSubview:state];

        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 35, view.frame.origin.y - 105 , 70, 70)];
        imgView.image = IMAGE(@"icon");
        [self addSubview:imgView];

        forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 60, frame.size.height - 50, 120, 30)];
        [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [forgetButton setTitleColor:RGBA(20.0f, 166.0f, 116.0f, 255.0f) forState:UIControlStateNormal];
        [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forgetButton];

        int margin = 15;
        int w = frame.size.width / 2 - margin - 15;
        int h = 40;

        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.cancleBtn.layer.cornerRadius = 3;
        self.cancleBtn.backgroundColor = [UIColor orangeColor];
        self.cancleBtn.frame = CGRectMake(margin, frame.size.height-h-10-44-(IOS7?20:0), w, h);
        [self.cancleBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancleBtn];

        self.goOnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goOnBtn setTitle:@"继续" forState:UIControlStateNormal];
        [self.goOnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.goOnBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.goOnBtn.layer.cornerRadius = 3;
        self.goOnBtn.backgroundColor = [UIColor clearColor];
        self.goOnBtn.enabled = NO;
        self.goOnBtn.frame = CGRectMake(frame.size.width - w - margin, frame.size.height-h-10-44-(IOS7?20:0), w, h);
        [self.goOnBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.goOnBtn];

    }

    return self;
}

- (void)leftBtnClick:(UIButton*) btn{
    if([gesturePasswordDelegate respondsToSelector:@selector(leftBtn:)])
        [gesturePasswordDelegate leftBtn:btn];
}

- (void)rightBtnClick:(UIButton*) btn{
    if([gesturePasswordDelegate respondsToSelector:@selector(rightBtn:)])
        [gesturePasswordDelegate rightBtn:btn];
}

- (void)gestureTouchBegin
{
    self.state.textColor = [UIColor blackColor];
    [self.state setText:@"完成后松开手指"];
}

- (void)forget
{
    if([gesturePasswordDelegate respondsToSelector:@selector(forget)])
        [gesturePasswordDelegate forget];
}

- (void)change
{
    if([gesturePasswordDelegate respondsToSelector:@selector(change)])
        [gesturePasswordDelegate change];
}

@end