//
//  Commodity.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commodity : NSObject

@property (nonatomic ,strong) NSString *commodityId;
@property (nonatomic ,strong) NSString *CommdityName;
@property (nonatomic ,strong) NSString *CommdityCode;

@property (nonatomic ,assign) float freight;
@property (nonatomic ,assign) float originaPrice;
@property (nonatomic ,assign) float currentPrice;

@property (nonatomic ,strong) NSURL *thumLogo;

@property (nonatomic ,assign) NSInteger salesVolume;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
