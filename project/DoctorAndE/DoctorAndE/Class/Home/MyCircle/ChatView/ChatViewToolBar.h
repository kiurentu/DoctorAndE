//
//  ChatViewToolBar.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-18.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  聊天工具栏
 */
@interface ChatViewToolBar : UIView
@property (weak, nonatomic) UITableView *tbView;
+(ChatViewToolBar*)instance;
- (instancetype)initWithTableView:(UITableView*)tb;
@end
