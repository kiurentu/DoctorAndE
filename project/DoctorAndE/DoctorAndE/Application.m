//
//  Application.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-17.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "Application.h"
#import "GesturePasswordController.h"

@interface Application ()
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation Application

- (instancetype)init
{
    self = [super init];

    if (self) {
        [self resetIdleTimer];
    }

    return self;
}

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];

    if (![[event allTouches] count]) {
        return;
    }

    [self resetIdleTimer];
}

/**
 *  重置计时器
 */
- (void)resetIdleTimer
{
    [self stopIdleTimer];
    if ([TOKEN length] && !APP.gestureIsShow && [[NSUserDefaults standardUserDefaults] boolForKey:KEY_USR_ON_OFF]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5*60 target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    }
}

/**
 *  停止计时器
 */
- (void)stopIdleTimer
{
    [_timer invalidate];
    self.timer = nil;
}

/**
 *  计时器执行的任务
 */
- (void)idleTimerExceeded
{
    if ([TOKEN length] && !APP.gestureIsShow && [[NSUserDefaults standardUserDefaults] boolForKey:KEY_USR_ON_OFF]) {
        APP.gestureIsShow = YES;
        GesturePasswordController *ges = [[GesturePasswordController alloc] initWithType:GesturePasswordTypeVerify];
        [[self.delegate window].rootViewController presentViewController:ges animated:YES completion:nil];
    }
}

@end