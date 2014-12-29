//
//  DateView.m
//  Medical
//
//  Created by iOS09 on 14-11-11.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "DateView.h"



@implementation DateView

+ (DateView *)instanceDateView {
	NSArray *dateView = [[NSBundle mainBundle]loadNibNamed:@"DateView" owner:nil options:nil];
	return [dateView objectAtIndex:0];
}

#pragma 移除view

- (IBAction)hideDateView:(id)sender {
	[self removeFromSuperview];
}

@end
