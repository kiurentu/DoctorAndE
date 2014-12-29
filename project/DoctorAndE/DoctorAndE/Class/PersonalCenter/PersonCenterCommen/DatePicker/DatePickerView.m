//
//  DatePickerView.m
//  Birethday
//
//  Created by UI08 on 14-11-13.
//  Copyright (c) 2014年 CZA. All rights reserved.
//
#import "DatePickerView.h"

@interface DatePickerView ()

@end

@implementation DatePickerView

- (id)initWithFrame:(CGRect)frame withDelegate:(id)delegate {
	self = [super initWithFrame:frame];
	if (self) {
		UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil] lastObject];
		self.delegate = delegate;
		self.mainView.layer.masksToBounds = YES;
		self.mainView.layer.cornerRadius = 3.5;
		self.mainView.layer.borderWidth = 1.0;
		self.mainView.layer.borderColor = [RGBCOLOR(181, 181, 181) CGColor];
		[self addSubview:view];
		view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.55];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancle)];
		[self addGestureRecognizer:tap];
	}
	return self;
}

- (void)cancle {
	[self removeFromSuperview];
}

- (IBAction)finish:(id)sender {
	if ([_delegate respondsToSelector:@selector(selectedDate:)]) {
		NSDate *selected = [_datePicker date];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		NSString *dateString = [dateFormatter stringFromDate:selected];
		[_delegate selectedDate:dateString];
		[self removeFromSuperview];
	}
}

@end
