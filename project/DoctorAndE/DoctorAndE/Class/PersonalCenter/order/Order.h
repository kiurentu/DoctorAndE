//
//  Order.h
//  Medical
//
//  Created by iOS09 on 14-11-10.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property (copy, nonatomic) NSString *orderType;
@property (copy, nonatomic) NSDate *orderDate;
@property (copy, nonatomic) NSString *orderHospital;
@property (copy, nonatomic) NSString *orderState;
@property (copy, nonatomic) NSString *orderDrName;

- (id)initWithAPPLYDict:(NSDictionary *)orderDict;

@end
