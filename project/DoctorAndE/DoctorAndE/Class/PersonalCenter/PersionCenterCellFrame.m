//
//  persionCenterCellFrame.m
//  医+e
//
//  Created by kang on 14-10-31.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//
#define kCellBorderWidth 5
#define kIconWidth  30
#define kIconHeight 30
#import "PersionCenterCellFrame.h"
#import "personCenter.h"
@implementation PersionCenterCellFrame

- (void)setPersonCenter:(PersonCenter *)personCenter {
	_personCenter = personCenter;
	CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;

	CGFloat imgX = kCellBorderWidth;
	CGFloat imgY = kCellBorderWidth;
	CGFloat imgWidth = kIconWidth;
	CGFloat imgHeight = kIconHeight;

	_img = CGRectMake(imgX, imgY, imgWidth, imgHeight);

	CGFloat textNameX = CGRectGetMaxX(_img) + kCellBorderWidth;
	CGFloat textNameY = CGRectGetMidY(_img) / 2;
	CGSize textNameSize = [personCenter.textName sizeWithFont:[UIFont systemFontOfSize:17]];
	_textNmae = (CGRect) {
		{ textNameX, textNameY }, textNameSize
	};

	CGFloat detailtextX = CGRectGetMaxX(_textNmae) + kCellBorderWidth;
	CGFloat detailtextY = 16;
	CGSize detailtextSize = [personCenter.detailtext sizeWithFont:[UIFont systemFontOfSize:11]];
	_detailtext = (CGRect) {
		{ detailtextX, detailtextY }, detailtextSize
	};
}

@end
