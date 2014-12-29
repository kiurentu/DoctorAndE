//
//  persionCenterCellFrame.h
//  医+e
//
//  Created by kang on 14-10-31.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonCenter;
@interface PersionCenterCellFrame : NSObject

@property (nonatomic, strong) PersonCenter *personCenter;

@property (nonatomic, assign, readonly) CGRect img;
@property (nonatomic, assign, readonly) CGRect textNmae;
@property (nonatomic, assign, readonly) CGRect detailtext;


@end
