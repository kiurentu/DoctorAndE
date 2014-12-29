//
//  Comment.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-27.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "Comment.h"

@implementation Comment
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        self.userPicture = [NSURL URLWithString:[dic objectForKey:@"imgPath"]];
        
        self.userName = [dic objectForKey:@"userName"];
#warning 评分
        self.grade = [dic objectForKey:@"score"];
        self.comment = [dic objectForKey:@"remark"];
        self.date = [dic objectForKey:@"createTime"];
    }
    
    return self;
}
@end
