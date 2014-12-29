//
//  GesturePasswordView.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

@protocol GesturePasswordDelegate <NSObject>
@optional
- (void)forget;
- (void)change;
- (void)leftBtn:(UIButton*)btn;
- (void)rightBtn:(UIButton*)btn;

@end

#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "GesturePasswordController.h"

/**
 *  手势密码的界面
 */
@interface GesturePasswordView : UIView <TouchBeginDelegate>

@property (nonatomic, strong) TentacleView *tentacleView;

@property (nonatomic, strong) UILabel *state;

@property (nonatomic, assign) id <GesturePasswordDelegate> gesturePasswordDelegate;

@property (nonatomic, strong) UIImageView   *imgView;
@property (nonatomic, strong) UIButton      *forgetButton;
@property (nonatomic, strong) UIButton      *cancleBtn;
@property (nonatomic, strong) UIButton      *goOnBtn;

- (id)initWithFrame:(CGRect)frame andType:(NSInteger) GesturePasswordType;

@end