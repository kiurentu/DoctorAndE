//
//  App.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-7.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "App.h"
#import "GesturePasswordController.h"
#import "EntityUser.h"

#define KEY_USR_JID         (@"__JID__")        // JID
#define KEY_USR_ROOT_URL    (@"__rootUrl__")    // 根url
#define KEY_USR_PORT        (@"__port__")       // 端口

@implementation App

static App *app;

+ (instancetype)sharedApp
{
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
            app = [[App alloc] init];
        });
    return app;
}

+ (void)destory
{
    app = nil;
}

- (id)init
{
    self = [super init];

    if (self) {
        self.gestureIsShow = NO;
        self.header = [[EntityHeader alloc] init];
        self.rootUrl = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USR_ROOT_URL];
        self.port = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USR_PORT];
        self.jID = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USR_JID];

        if (!_rootUrl || [_rootUrl isEqualToString:@""]) {
            self.rootUrl = DEFAULT_ROOT_URL;
        }

        if (!_port || [_port isEqualToString:@""]) {
            self.port = DEFAULT_PORT;
        }
    }

    return self;
}

- (NSString *)getServerUrl
{
    __autoreleasing NSString *serverUrl = [NSString stringWithFormat:@"http://%@:%@", app.rootUrl, app.port];

    return serverUrl;
}

- (void)setRootUrl:(NSString *)rootUrl andPort:(NSString *)port
{
    app.rootUrl = rootUrl;
    app.port = port;
}

- (void)setRootUrl:(NSString *)rootUrl
{
    _rootUrl = rootUrl;
    [[NSUserDefaults standardUserDefaults] setObject:rootUrl forKey:KEY_USR_ROOT_URL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPort:(NSString *)port
{
    _port = port;
    [[NSUserDefaults standardUserDefaults] setObject:port forKey:KEY_USR_PORT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setJID:(NSString *)jID
{
    _jID = jID;
    [[NSUserDefaults standardUserDefaults] setObject:jID forKey:KEY_USR_JID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)myJID
{
    return [NSString stringWithFormat:@"%@%@", _jID, DEFAULT_XMPP_SERVER];
}

- (EntityUser*)getUserInfo
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USR_INFO];
    if(dic) {
        return [[EntityUser alloc] initWithDic:dic];
    }
    return nil;
}

- (void)clearUsrLoginInfo
{
    TOKEN = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_USR_INFO];
    // 断开xmpp连接
    KeychainItemWrapper *keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"__DoctorAndE_Config__" accessGroup:nil];
    [keychin resetKeychainItem];
    [[[KeychainItemWrapper alloc]initWithIdentifier:@"__DoctorAndE_Config__" accessGroup:nil] setObject:@"" forKey:(__bridge id)kSecValueData];
    [GesturePasswordController clear];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:KEY_USR_ON_OFF];
}

@end