//
//  SetRemind.h
//  DoctorAndE
//
//  Created by kang on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetRemind : NSObject

@property (nonatomic,copy) NSString *xm;//成员名
@property (nonatomic, copy) NSString *memberId;//成员ID
@property (nonatomic,copy) NSString *message;//是否短信提醒
@property (assign,nonatomic) BOOL isSelect;//是否选中

+ (id)setRemindModelWithDict:(NSDictionary *)dict;


@end
