//
//  STUNet.h
//  iOSTest
//
//  Created by skytoup on 14-11-6.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaitView.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#define DEFAULT_TIME_OUT (15.0f)

/**
 *  网络工具类
 */
@protocol STUNetDelegate <NSObject>
//#pragma mark - STUNetDelegate
//- (void)STUNetRequestSuccessByTag:(NSString*) tag withDic:(NSDictionary*)dic;
//- (void)STUNetRequestFailByTag:(NSString*) tag withDic:(NSDictionary*)dic withError:(NSError*) err withMsg:(NSString*) errMsg;
//- (void)STUNetRequestErrorByTag:(NSString*) tag withError:(NSError*) err;
//- (void)STUNetRequestCancelByTag:(NSString*) tag;
@optional
/**
 *  获取数据成功
 *
 *  @param tag      请求的tag
 *  @param jsonData 获取到的数据
 */
- (void)STUNetRequestSuccessByTag:(NSString*) tag withDic:(NSDictionary*)dic;
/**
 *  获取数据失败
 *
 *  @param tag      请求的tag
 *  @param jsonData 获取到的数据
 *  @param err      访问的错误信息
 *  @param errMsg   后台返回的错误信息
 */
- (void)STUNetRequestFailByTag:(NSString*) tag withDic:(NSDictionary*)dic withError:(NSError*) err withMsg:(NSString*) errMsg;
/**
 *  请求失败
 *
 *  @param tag 请求的tag
 *  @param err 错误信息
 */
- (void)STUNetRequestErrorByTag:(NSString*) tag withError:(NSError*) err;
/**
 *  请求取消
 *
 *  @param tag 请求的tag
 */
- (void)STUNetRequestCancelByTag:(NSString*) tag;
@end

@interface STUNet : NSObject
@property (weak, nonatomic) id<STUNetDelegate> delegate;
- (id)initWithDelegate:(id<STUNetDelegate>) delegate;
- (void)requestCancleAll;
- (void)requestCancelByTag:(NSString*) tag;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andShowDiaMsg:(NSString*) msg;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache andShowDiaMsg:(NSString*) msg;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andShowDiaMsg:(NSString*) msg;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andIsCache:(BOOL) isCache andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andShowDia:(WaitView*) dia;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache andShowDia:(WaitView*) dia;
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache;
/**
 *  创建一个请求，从网络获取数据
 *
 *  @param tag     请求的标志
 *  @param url     请求的地址
 *  @param body    请求的参数
 *  @param sec     请求超时的时间
 *  @param isCache 是否缓存
 *  @param dia     显示的等待对话框
 */
- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andIsCache:(BOOL) isCache andShowDia:(WaitView*) dia;
/**
 *  上传图片
 *
 *  @param tag 请求标志
 *  @param img 上传的图片
 */
- (void)requestTag:(NSString *)tag andUnloadImage:(UIImage*)img;
@end
