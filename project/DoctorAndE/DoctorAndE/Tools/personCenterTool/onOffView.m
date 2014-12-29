//
//  onOffView.m
//  smartAppforiPhone
//
//  Created by AngelSeaHappiness on 13-5-7.
//  Copyright (c) 2013年 smartAppforiPhone. All rights reserved.
//
// 设置UIImage
#define SETIMAGE(IMAGENAME) [UIImage imageWithContentsOfFile :[[NSBundle mainBundle] pathForResource:IMAGENAME ofType:nil]]
#import "onOffView.h"
// #import "hFile.h"

@implementation onOffView
@synthesize bgImageV, onOffBtn;
@synthesize delegate;
@synthesize isShowListViewRight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code
        [self setFrame:frame];
        [self initCtrl];
    }

    return self;
}

- (void)initCtrl
{
    self.bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [bgImageV setBackgroundColor:[UIColor clearColor]];
    [bgImageV setImage:SETIMAGE(@"switch_off.png")];
    [self addSubview:self.bgImageV];

    isShowListViewRight = NO;

    self.onOffBtn = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 25, 25)];
    [onOffBtn setBackgroundColor:[UIColor clearColor]];
    [onOffBtn setImage:SETIMAGE(@"switch_dot.png")];
    [self addSubview:self.onOffBtn];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];

    beginPoint = [touch locationInView:self];

    if (isShowListViewRight == NO) {
        [self swipeRightView];
        isShowListViewRight = YES;
        [delegate swipeRightFromOnOffView:self];
    } else {
        [self swipeLeftView];
        isShowListViewRight = NO;
        [delegate swipeLeftFromOnOffView:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];

    CGPoint nowPoint = [touch locationInView:self];

    CGRect frame = self.frame;

    frame.origin.x += nowPoint.x - beginPoint.x;

    if (frame.origin.x < self.frame.origin.x) {
        frame.origin.x = self.frame.origin.x;
        [self swipeLeftView];
        isShowListViewRight = NO;
        [delegate swipeLeftFromOnOffView:self];
    } else if (frame.origin.x > frame.size.width) {
        frame.origin.x = self.frame.origin.x;
        [self swipeRightView];
        isShowListViewRight = YES;
        [delegate swipeRightFromOnOffView:self];
    }

    frame.origin.y = frame.origin.y;
    self.frame = frame;
}

- (void)setisShowListViewRight:(BOOL)bol
{
    isShowListViewRight = bol;

    if (bol) {
        [self swipeRightView];
    } else {
        [self swipeLeftView];
    }
}

- (void)swipeLeftView
{
    [self.bgImageV setImage:SETIMAGE(@"switch_off.png")];
    //    [self.onOffBtn setImage:SETIMAGE(@"offBtn.png")];
    [UIView animateWithDuration:0.01
            delay       :0.0
            options     :0
            animations  :^{
        [onOffBtn setFrame:CGRectMake(0, 1, 25, 25)];
    }

            completion  :^(BOOL finished) {
        [UIView animateWithDuration:0.01
                delay       :0.0
                options     :UIViewAnimationCurveEaseIn
                animations  :^{
            [onOffBtn setFrame:CGRectMake(0, 1, 25, 25)];
        }

                completion  :^(BOOL finished) {
            // CGAffineTransform rotation = CGAffineTransformMakeRotation(degressToRadian(0));
        }];
    }];
}

- (void)swipeRightView
{
    [bgImageV setImage:SETIMAGE(@"switch_on.png")];
    //    [onOffBtn setImage:SETIMAGE(@"onBtn.png")];
    [UIView animateWithDuration:0.01
            delay       :0.0
            options     :0
            animations  :^{
        [onOffBtn setFrame:CGRectMake(25, 1, 25, 25)];
    }

            completion  :^(BOOL finished) {
        [UIView animateWithDuration:0.01
                delay       :0.0
                options     :UIViewAnimationCurveEaseIn
                animations  :^{
            [onOffBtn setFrame:CGRectMake(25, 1, 25, 25)];
        }

                completion  :^(BOOL finished) {
            // CGAffineTransform rotation = CGAffineTransformMakeRotation(degressToRadian(0));
        }];
    }];
}

@end