//
//  EquipMode.m
//  DoctorAndE
//
//  Created by kang on 14-12-2.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "EquipMode.h"

@implementation EquipMode
- (id)initWithDict:(NSDictionary *)dic {
	if (self = [super init]) {
		
		self.equipNameStr = [dic objectForKey:@"name"];
		self.equipNumberStr = [dic objectForKey:@"model"];
        self.equipTestArr = [dic objectForKey:@"listType"] ;
//		self.equipTestStr = [dic objectForKey:@"listType"][@"type"] ;
		self.serialNumberStr = [dic objectForKey:@"serial"] ;
	}
	return self;
}
@end
