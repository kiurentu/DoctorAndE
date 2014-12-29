//
//  EntityHeader.h
//  iOSTest
//
//  Created by skytoup on 14-11-7.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

/**
 *  提交数据的头
 */
@interface EntityHeader : BaseEntity
@property (strong, nonatomic) NSString *token; // 令牌
@property (strong, nonatomic) NSString *time_stamp; // 时间戳，格式：yyyyMMDDHHmmss（年月日时分秒）
@end
