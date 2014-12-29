//
//  Comment.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-27.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (strong, nonatomic)  NSURL *userPicture;
@property (strong, nonatomic)  NSString *userName;
@property (strong, nonatomic)  NSString *grade;
@property (strong, nonatomic)  NSString *comment;
@property (strong, nonatomic)  NSString *date;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
