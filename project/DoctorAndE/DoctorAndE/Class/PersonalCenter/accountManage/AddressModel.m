//
//  AddressModel.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
- (id)initWithDict:(NSDictionary *)dict {
	if (self = [super init]) {
		//解析字典属性
		self.userName = dict[@"userName"];
        self.phone = dict[@"mobile"];
        self.address = dict[@"address"];
        self.postalCode = dict[@"postalCode"];
        self.receiverInfoId = dict[@"id"];
	}
    
	return self;
}
+ (id)addressModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}

@end
