//
//  ChatViewFace.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-18.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  表情选择的View
 */
@interface ChatViewFace : UIView
+ (ChatViewFace*)instance;
- (instancetype)initWIthTextView:(UITextView*)tv;
@end
