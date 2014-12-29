//
//  ApplyCellFrame.h
//  Medical
//
//  Created by iOS09 on 14-11-9.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Apply;
@interface ApplyCellFrame : NSObject

@property (nonatomic, strong) Apply *apply;


@property (nonatomic, assign, readonly) CGRect apType;
@property (nonatomic, assign, readonly) CGRect apDate;
@property (nonatomic, assign, readonly) CGRect apHospital;
@property (nonatomic, assign, readonly) CGRect apState;



@end
