//
//  FamilyModel.m
//  Person
//
//  Created by UI08 on 14-10-31.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import "FamilyModel.h"

@implementation FamilyModel
- (id)initWithDict:(NSDictionary *)dict {
	if (self = [super init]) {
		//解析字典属性
		self.xm = dict[@"xm"];
		self.nickname = dict[@"nickname"];
        self.mobile = dict[@"mobile"];
        self.sfzh = dict[@"sfzh"];
        self.memberId = dict[@"id"];
        self.message = dict[@"message"];
        self.sex = dict[@"sex"];
        self.birthday = dict[@"birthday"];
        self.validateSfzh = dict[@"validateSfzh"];
        self.isDefaultMember = [dict[@"isDefaultMember"] intValue];
        
		self.isSelected = NO;

	}

	return self;
}

+ (id)FamilyModelWithDict:(NSDictionary *)dict {
	return [[self alloc] initWithDict:dict];
}

@end
