//
//  personCenter.m
//  医+e
//
//  Created by kang on 14-10-31.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "PersonCenter.h"

@implementation PersonCenter
- (id)initWithDict:(NSDictionary *)dict {
	if (self = [super init]) {
		self.textName = dict[@"textname"];
		self.img = dict[@"image"];
		self.detailtext = dict[@"detailtext"];
	}

	return self;
}

@end
