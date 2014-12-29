//
//  BaseEntity.h
//  iOSTest
//
//  Created by skytoup on 14-11-7.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  实体类的基类，所有实体类都需要继承的基类
 */
@interface BaseEntity : NSObject
- (instancetype)initWithDic:(NSDictionary*)dic;
/**
 *  把成员变量转为字典
 *
 *  @return 字典对象
 */
- (NSDictionary*)toDic;
/**
 *  把成员变量转为Json
 *
 *  @return jsonStr
 */
- (NSString*)toJson;
@end
