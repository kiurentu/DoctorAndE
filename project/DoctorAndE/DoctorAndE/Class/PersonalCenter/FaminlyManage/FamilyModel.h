//
//  FamilyModel.h
//  Person
//
//  Created by UI08 on 14-10-31.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyModel : NSObject

@property (nonatomic, copy) NSString *xm;//成员名
@property (nonatomic, copy) NSString *nickname;//昵称
@property (nonatomic, copy) NSString *sfzh;//身份证号
@property (nonatomic, copy) NSString *mobile;//手机号码
@property (nonatomic, copy) NSString *sex;//性别
@property (nonatomic, copy) NSString *memberId;//成员ID
@property (nonatomic, copy) NSString *message;//是否发送短信提醒 0：不发送 1：发送
@property (nonatomic, copy) NSString *birthday;//生日
@property (nonatomic, copy) NSString *validateSfzh;//是否已验证身份证号  0：审核中  1：审核通过 2：审核不通过  3：未验证
@property (nonatomic, assign) int isDefaultMember;// 是否是默认成员，0：否 1：是

@property (nonatomic, assign) BOOL isSelected;//是否选中

+ (id)FamilyModelWithDict:(NSDictionary *)dict;

@end
