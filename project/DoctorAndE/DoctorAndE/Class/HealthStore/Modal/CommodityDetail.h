//
//  CommodityDetail.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-25.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityDetail : NSObject

@property (nonatomic ,strong) NSString *commodityId;
@property (nonatomic ,strong) NSString *commdityName;
@property (nonatomic ,strong) NSString *commdityCode;
@property (nonatomic ,strong) NSString *commdityDetail;

@property (nonatomic ,assign) NSInteger stockQuantity;
@property (nonatomic ,assign) NSInteger salesVolume;

@property (nonatomic ,assign) float express;
@property (nonatomic ,assign) float originaPrice;
@property (nonatomic ,assign) float currentPrice;

@property (nonatomic ,strong) NSArray *pathList;
@property (nonatomic ,strong) NSArray *pathDetailList;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
