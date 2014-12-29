//
//  EntityHeader.m
//  iOSTest
//
//  Created by skytoup on 14-11-7.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "EntityHeader.h"

#define KEY_USR_TOKEN (@"__token__") // Token

@interface EntityHeader ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation EntityHeader
- (id)init {
    self = [super init];
    if(self){
        self.dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyyMMddHHmmss";

        self.token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USR_TOKEN];
        _token = _token ? _token : @"" ;
        [self update];
    }
    return self;
}

- (void)update {
    self.time_stamp = [_dateFormatter stringFromDate:[NSDate date] ];
}

- (void)setToken:(NSString *)token {
    _token = token;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_USR_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableDictionary*)toDic {
    [self update];
    __autoreleasing NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.token forKey:@"token"];
    [dic setValue:self.time_stamp forKey:@"time_stamp"];
    return dic;
}

@end
