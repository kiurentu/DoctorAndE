//
//  personCenter.h
//  医+e
//
//  Created by kang on 14-10-31.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonCenter : NSObject
//@property (weak, nonatomic) IBOutlet UIImageView *img;
//@property (weak, nonatomic) IBOutlet UILabel *textNmae;
//@property (weak, nonatomic) IBOutlet UILabel *detailtext;

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *textName;
@property (nonatomic, copy) NSString *detailtext;
- (id)initWithDict:(NSDictionary *)dict;

@end
