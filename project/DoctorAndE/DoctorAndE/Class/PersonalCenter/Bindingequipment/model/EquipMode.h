//
//  EquipMode.h
//  DoctorAndE
//
//  Created by kang on 14-12-2.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  设备model类

#import <Foundation/Foundation.h>

@interface EquipMode : NSObject

@property (nonatomic,copy)NSString *equipNameStr;
@property (nonatomic,copy)NSString *equipNumberStr;
@property (nonatomic,copy)NSMutableArray *equipTestArr;
@property (nonatomic,copy)NSString *equipTestStr;
@property (nonatomic,copy)NSString *serialNumberStr;

- (id)initWithDict:(NSDictionary *)dict;
@end
