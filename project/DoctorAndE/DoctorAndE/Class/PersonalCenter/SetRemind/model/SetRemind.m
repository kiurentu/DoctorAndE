//
//  SetRemind.m
//  DoctorAndE
//
//  Created by kang on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "SetRemind.h"

@implementation SetRemind

- (id)initWithDict:(NSDictionary *)dic {
    
	if (self = [super init]) {
        
        self.xm = dic[@"xm"];
        self.memberId = dic[@"id"];
        self.message = dic[@"message"];
       
	}
	return self;
}

+ (id)setRemindModelWithDict:(NSDictionary *)dict;
{
    return [[self alloc] initWithDict:dict];
}

@end
