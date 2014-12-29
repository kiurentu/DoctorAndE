//
//  Commodity.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "Commodity.h"

@implementation Commodity

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.commodityId = [dic objectForKey:@"id"];
        self.CommdityName = [dic objectForKey:@"name"];
        self.CommdityCode = [dic objectForKey:@"code"];
        
        self.freight = [[dic objectForKey:@"EMS"] floatValue];
        self.originaPrice = [[dic objectForKey:@"originalPrice"] floatValue];
        self.currentPrice = [[dic objectForKey:@"currentPrice"] floatValue];
        
        
        self.thumLogo =[NSURL URLWithString:[dic objectForKey:@"thumLogo"]];
        
        self.salesVolume = [[dic objectForKey:@"salesVolume"]integerValue];
    }
    
    return self;
}
@end
