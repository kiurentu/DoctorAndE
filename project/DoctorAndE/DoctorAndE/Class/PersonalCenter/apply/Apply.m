//
//  Apply.m
//  Medical
//
//  Created by iOS09 on 14-11-10.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "Apply.h"

@implementation Apply
- (id)initWithAPPLYDict:(NSDictionary *)applyDict {
	if (self = [super init]) {
		self.applyType = applyDict[@"applytype"];
		self.applyDate = applyDict[@"applydate"];
		self.applyHospital = applyDict[@"applyhospittal"];
		self.applyState = applyDict[@"applydict"];
		self.applyName = applyDict[@"applyname"];
		self.applySex = applyDict[@"applysex"];
		self.applyPhone = applyDict[@"applyphone"];
		self.applyPersonID = applyDict[@"applypersonID"];
	}
	return self;
}

@end
