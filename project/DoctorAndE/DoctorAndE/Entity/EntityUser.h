//
//  EntityUser.h
//  DoctorAndE
//
//  Created by skytoup on 14-12-17.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "BaseEntity.h"

/**
 *  用户信息
 */
@interface EntityUser : BaseEntity
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *imagePath;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *sfzh;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *userName;
@end
