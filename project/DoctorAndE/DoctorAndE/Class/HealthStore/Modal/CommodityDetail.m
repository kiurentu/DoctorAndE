//
//  CommodityDetail.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-25.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "CommodityDetail.h"

@implementation CommodityDetail

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        
        self.commodityId = [dic objectForKey:@"id"];
        self.CommdityName = [dic objectForKey:@"name"];
        self.CommdityCode = [dic objectForKey:@"code"];
        self.commdityDetail = [dic objectForKey:@"details"];
        
        self.stockQuantity = [[dic objectForKey:@"stockQuantity"] integerValue];
        self.salesVolume = [[dic objectForKey:@"salesVolume"] integerValue];
        
        self.express = [[dic objectForKey:@"express"] floatValue];
        self.originaPrice = [[dic objectForKey:@"originalPrice"] floatValue];
        self.currentPrice = [[dic objectForKey:@"currentPrice"] floatValue];
        
        NSArray *temppathDetail = [self ChangeDictionaryFromString:[dic objectForKey:@"pathDetailListArray"]];
        self.pathDetailList = [[NSArray alloc]initWithArray:temppathDetail];
        
        NSArray *temppath = [self ChangeDictionaryFromString:[dic objectForKey:@"pathListArray"]];
        self.pathList = [[NSArray alloc]initWithArray:temppath];

    }
    
    return self;
}

-(NSArray *)ChangeDictionaryFromString:(NSArray *)arr{
    NSArray *tempArr = [[NSArray alloc]initWithArray:arr];
    NSMutableArray *tempMutableArr = [NSMutableArray array];
    for (NSDictionary *dic in tempArr ) {
        NSString *str = [dic objectForKey:@"photo"];
        [tempMutableArr addObject:str];
    }
    return tempMutableArr;
}
@end
