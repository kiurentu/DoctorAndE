//
//  ApplyCell.m
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "ApplyCell.h"
#import "MyApplyViewController.h"
#import "Apply.h"


@implementation ApplyCell {
}



- (void)setType:(NSString *)type {
	if (!_type) {
		self.applyType.text = @"家庭病床";
	}
}

- (void)setDate:(NSString *)date {
	if (!_date) {
		self.applyDate.text = @"2014-11-11";
	}
}

- (void)setHospital:(NSString *)hospital {
	if (!_hospital) {
		self.applyHospital.text = @"红旗医院";
	}
}

- (void)setState:(NSString *)state {
	if (!_state) {
		self.applyState.text = @"待审核";
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end
