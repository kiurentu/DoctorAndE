//
//  ApplyCellFrame.m
//  Medical
//
//  Created by iOS09 on 14-11-9.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#define kLabelBoederWith 5
#define kLabelWidth 65
#define kLabelHeight 30

#import "ApplyCellFrame.h"
#import "Apply.h"
@implementation ApplyCellFrame



- (void)setApplyCellF:(Apply *)apply {
	_apply = apply;
	CGFloat cellWith = [UIScreen mainScreen].bounds.size.width;

	CGFloat labeltypeX = kLabelBoederWith;
	CGFloat labeltypeY = kLabelBoederWith;
	CGFloat labelWight = kLabelWidth;
	CGFloat labelHeight = kLabelHeight;

	_apType = CGRectMake(labeltypeX, labeltypeY, labelWight, labelWight);

	CGFloat labeldateX = kLabelBoederWith;
	CGFloat labeldateY = CGRectGetMaxY(_apType) + kLabelBoederWith;

	_apDate = CGRectMake(labeldateX, labeldateY, labelWight, labelHeight);

	CGFloat labelhospitalX = kLabelBoederWith;
	CGFloat labelhospitalY = CGRectGetMaxY(_apDate) + kLabelBoederWith;

	_apHospital = CGRectMake(labelhospitalX, labelhospitalY, labeltypeX, labeltypeY);

	CGFloat labelStateX = CGRectGetMaxX(_apType) + 100;
	CGFloat labelSyateY = kLabelBoederWith;
	_apState = CGRectMake(labelStateX, labelSyateY, labelWight, labelHeight);
}

@end
