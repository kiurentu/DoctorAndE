//
//  Order.m
//  Medical
//
//  Created by iOS09 on 14-11-10.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "Order.h"

@implementation Order

- (id)initWithAPPLYDict:(NSDictionary *)orderDict {
	if (self = [super init]) {
		self.orderType = orderDict[@"ordertype"];
		self.orderDate = orderDict[@"orderdate"];
		self.orderHospital = orderDict[@"orderhospittal"];
		self.orderState = orderDict[@"orderdict"];
		self.orderDrName = orderDict[@"orderDrname"];
	}
	return self;
}

@end
