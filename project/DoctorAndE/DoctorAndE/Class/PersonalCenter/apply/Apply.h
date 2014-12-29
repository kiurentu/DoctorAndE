//
//  Apply.h
//  Medical
//
//  Created by iOS09 on 14-11-10.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apply : NSObject

@property (nonatomic, copy) NSString *applyType;
@property (nonatomic, copy) NSString *applyDate;
@property (nonatomic, copy) NSString *applyHospital;
@property (nonatomic, copy) NSString *applyState;
@property (nonatomic, copy) NSString *applyName;
@property (nonatomic, copy) NSString *applySex;
@property (nonatomic, copy) NSString *applyPhone;
@property (nonatomic, copy) NSString *applyPersonID;


- (id)initWithAPPLYDict:(NSDictionary *)applyDict;

@end
