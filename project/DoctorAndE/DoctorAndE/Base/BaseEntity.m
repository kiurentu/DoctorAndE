//
//  BaseEntity.m
//  iOSTest
//
//  Created by skytoup on 14-11-7.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "BaseEntity.h"
#import <objc/runtime.h>
#import "JSONKit.h"

@implementation BaseEntity

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (NSDictionary*)toDic {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    __autoreleasing NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (i = 0; i != outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id obj = [self valueForKey:propertyName];
        if([obj isKindOfClass:[BaseEntity class] ]){
            obj = [obj toJson];
        }
        if(!obj) {
            [dic setObject:@"" forKey:propertyName];
        }else if([obj isKindOfClass:[NSObject class] ]){
            [dic setObject:[obj copy] forKey:propertyName];
        } else {
            [dic setObject:obj forKey:propertyName];
        }
    }
    free(properties);
    return dic;
}

- (NSString*)toJson {
    return [[self toDic] JSONString];
}

@end
