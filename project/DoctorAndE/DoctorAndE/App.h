//
//  App.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-7.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityHeader.h"
#import "KeychainItemWrapper.h"

@class EntityUser;

/**
 *  整个应用共享常用数据
 */
@interface App : NSObject
/**
 *  获取App的单例
 *
 *  @return App单例
 */
+ (instancetype)sharedApp;
/**
 *  销毁App单例
 */
+ (void)destory;
/**
 *  获取服务器地址
 *
 *  @return 服务器地址
 */
- (NSString*)getServerUrl;
/**
 *  设置服务器地址
 *
 *  @param rootUrl 根的url
 *  @param port    端口
 */
- (void)setRootUrl:(NSString*) rootUrl andPort:(NSString*) port;
/**
 *  获取jID
 *
 *  @return jID
 */
- (NSString*)myJID;
/**
 *  清除用户登录信息
 */
- (void)clearUsrLoginInfo;
/**
 *  用户信息
 */
- (EntityUser*)getUserInfo;

/**
 *  手势密码是否已在显示
 */
@property (assign, nonatomic) BOOL gestureIsShow;
// token、timeStamp
@property (strong, nonatomic) EntityHeader *header;
// Root URL
@property (copy, nonatomic) NSString *rootUrl;
// port
@property (copy, nonatomic) NSString *port;
// JID
@property (copy, nonatomic) NSString *jID;
@end
