//
//  AddressModel.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

/**
 *  地址模型
 */

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *postalCode;
@property (nonatomic,copy) NSString *receiverInfoId;

+ (id)addressModelWithDict:(NSDictionary *)dict;


@end
