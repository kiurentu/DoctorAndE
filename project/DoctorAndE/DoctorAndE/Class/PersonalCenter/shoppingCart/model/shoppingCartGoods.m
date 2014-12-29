//
//  shoppingCartGoods.m
//  DoctorAndE
//
//  Created by kang on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ShoppingCartGoods.h"

@implementation ShoppingCartGoods
- (id)initWithDict:(NSDictionary *)dic {
	if (self = [super init]) {
		self.isDelete  = NO;
		self.goodsImg = [dic objectForKey:@"goodsImg"];
		self.goodsName = [dic objectForKey:@"goodsName"];
		self.price = [[dic objectForKey:@"price"] floatValue];
		self.now_number = [[dic objectForKey:@"now_number"] floatValue];
	}
	return self;
}

@end
