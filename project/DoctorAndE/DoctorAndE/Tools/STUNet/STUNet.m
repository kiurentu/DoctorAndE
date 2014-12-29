//
//  STUNet.m
//  iOSTest
//
//  Created by skytoup on 14-11-6.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "STUNet.h"
#import "AppDelegate.h"

@interface STUNet ()
@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) NSMutableDictionary *tagToOperation; // tag -> request
@property (strong, nonatomic) NSMutableDictionary *tagToDia; // tag -> request
@end

@implementation STUNet

- (id)init {
    self = [super init];
    if(self){
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 3;
        self.tagToOperation = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithDelegate:(id<STUNetDelegate>) delegate {
    self = [self init];
    if(self){
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    [self requestCancleAll];
}

- (void)requestCancleAll{
    [_operationQueue cancelAllOperations];
    [_tagToDia enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [obj dismiss];
    }];
    [_tagToDia removeAllObjects];
    [_tagToOperation removeAllObjects];
}

- (void)requestCancelByTag:(NSString*) tag {
    [[_tagToOperation objectForKey:tag] cancel];
    [[_tagToDia objectForKey:tag] dismiss];
    [_tagToDia removeObjectForKey:tag];
    [_tagToOperation removeObjectForKey:tag];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andShowDiaMsg:(NSString*) msg {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:NO andShowDiaMsg:msg andCancelable:YES];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache andShowDiaMsg:(NSString*) msg {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:NO andShowDiaMsg:msg andCancelable:YES];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andShowDiaMsg:(NSString*) msg {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:sec andIsCache:NO andShowDiaMsg:msg andCancelable:YES];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:NO andShowDiaMsg:msg andCancelable:cancelable];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:NO andShowDiaMsg:msg andCancelable:cancelable];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:sec andIsCache:NO andShowDiaMsg:msg andCancelable:cancelable];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andIsCache:(BOOL) isCache andShowDiaMsg:(NSString*) msg andCancelable:(BOOL) cancelable {
    WaitView *dia = [[WaitView alloc] initWithTitle:msg];
    dia.cancelable = cancelable;
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:sec andIsCache:isCache andShowDia:dia];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:NO andShowDia:nil];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andShowDia:(WaitView*) dia {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:sec andIsCache:NO andShowDia:dia];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:sec andIsCache:NO andShowDia:nil];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache andShowDia:(WaitView*) dia {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:isCache andShowDia:dia];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andIsCache:(BOOL) isCache {
    [self requestTag:tag andUrl:url andBody:body andTimeOutSec:DEFAULT_TIME_OUT andIsCache:isCache andShowDia:nil];
}

- (void)requestTag:(NSString *)tag andUrl:(NSString *)url andBody:(NSDictionary*) body andTimeOutSec:(long) sec andIsCache:(BOOL) isCache andShowDia:(WaitView*) dia {
    
    NSDictionary *params = @{@"body":body, @"header":[APP.header toDic]};
    NSLog(@"请求的地址：%@\n参数：%@\n\n", url, [params JSONString]);
    
    NSError *error;
    NSMutableURLRequest *request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:&error];
    request.timeoutInterval = sec;
    if(error){
        if([_delegate respondsToSelector:@selector(STUNetRequestErrorByTag:withError:)]){
            [_delegate STUNetRequestErrorByTag:tag withError:error];
        }
        return;
    }

    WEAK_SELF(this);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [this.tagToOperation removeObjectForKey:tag];
        id dic = [operation.responseString objectFromJSONString];
        NSLog(@"Tag：%@\n数据：%@\n\n", tag, dic);

        NSString *errMsg = nil;
        switch ([dic[@"result"] intValue]) {
            case 0:
                break;
            case 1:
                errMsg = @"消息格式错误";
                break;
            case 2:
            {
                errMsg = @"Token验证错误";
                [APP clearUsrLoginInfo];
//                [Tools showMessage:@"Token验证错误，请重新登录"];
                UIAlertView *dia = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                dia.title = @"提示";
                dia.message = @"Token验证错误，请重新登录";
                [dia show];
                [AppDelegate notificationInitController:InitLoginController];
                break;
            }
            case 3:
            {
                errMsg = @"Token过期";
                [APP clearUsrLoginInfo];
//                [Tools showMessage:@"身份验证过期，请重新登录"];
                UIAlertView *dia = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                dia.title = @"提示";
                dia.message = @"身份验证过期，请重新登录";
                [dia show];
                [AppDelegate notificationInitController:InitLoginController];
                break;
            }
            case 4:
                errMsg = @"找不到对应方法";
                break;
            case 5:
                errMsg = @"家庭病床审核不通过";
                break;
            default:
                errMsg = @"未知错误";
                break;
        }
        
        if(errMsg){
            if([this.delegate respondsToSelector:@selector(STUNetRequestFailByTag:withDic:withError:withMsg:)]){
                [this.delegate STUNetRequestFailByTag:tag withDic:dic withError:error withMsg:errMsg];
            }
        }else{
            if(isCache){
                
            }
            if([this.delegate respondsToSelector:@selector(STUNetRequestSuccessByTag:withDic:)]){
                [this.delegate STUNetRequestSuccessByTag:tag withDic:dic];
            }
        }
        
        [this.tagToDia removeObjectForKey:tag];
        [dia dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [this.tagToOperation removeObjectForKey:tag];
        if([this.delegate respondsToSelector:@selector(STUNetRequestErrorByTag:withError:)]){
            [this.delegate STUNetRequestErrorByTag:tag withError:error];
        }
        
        [this.tagToDia removeObjectForKey:tag];
        [dia dismiss];
    }];
    
    [[_tagToOperation objectForKey:tag] cancel];
    [_tagToOperation setObject:operation forKey:tag];
    [self.operationQueue addOperation:operation];
    
    if(dia && dia.cancelable){
        WEAK_SELF(this);
        dia.cancelBlock = ^{
            [this.tagToDia removeObjectForKey:tag];
            if([this.delegate respondsToSelector:@selector(STUNetRequestCancelByTag:)]){
                [this.delegate STUNetRequestCancelByTag:tag];
            }
        };
    }
    
    if(dia) {
        [_tagToDia setObject:dia forKey:tag];
    }
    [dia show];
}

- (void)requestTag:(NSString *)tag andUnloadImage:(UIImage*)img {
    
    static NSString *BOUNDARY = @"efb721abe";
    NSString *fileName = @"85477947-1fc2-447d-809b-22efb721abe9.png";
    NSString *fileKey = @"85477947-1f";
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    req.URL = [NSURL URLWithString:URL_UNLOAD_IMG];
    req.HTTPMethod = @"POST";
    [req setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@", BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSMutableString *mStr = [[NSMutableString alloc] init];
    [mStr appendFormat:@"--%@\r\n", BOUNDARY];
    [mStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileKey, fileName];
    [mStr appendString:@"Content-Type: image/pjpeg\r\n\r\n"];
    [data appendData:[mStr dataUsingEncoding:NSUTF8StringEncoding] ];
    [data appendData:UIImageJPEGRepresentation(img, 1.0f) ];
    mStr = [[NSMutableString alloc] init];
    [mStr appendFormat:@"\r\n--%@--", BOUNDARY];
    [data appendData:[mStr dataUsingEncoding:NSUTF8StringEncoding] ];
    req.HTTPBody = data;
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)data.length];
    [req setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    req.timeoutInterval = DEFAULT_TIME_OUT;
    
    WEAK_SELF(this);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [this.tagToOperation removeObjectForKey:tag];
        id dic = [operation.responseString objectFromJSONString];
        NSLog(@"Tag：%@\n数据：%@\n\n", tag, dic);
        
        NSString *errMsg = nil;
        switch ([dic[@"result"] intValue]) {
            case 0:
                break;
            case 1:
                errMsg = @"消息格式错误";
                break;
            case 4:
                errMsg = @"找不到对应方法";
                break;
            default:
                errMsg = @"未知错误";
                break;
        }
        
        if(errMsg){
            if([this.delegate respondsToSelector:@selector(STUNetRequestFailByTag:withDic:withError:withMsg:)]){
                [this.delegate STUNetRequestFailByTag:tag withDic:dic withError:nil withMsg:errMsg];
            }
        }else{
            if([this.delegate respondsToSelector:@selector(STUNetRequestSuccessByTag:withDic:)]){
                [this.delegate STUNetRequestSuccessByTag:tag withDic:dic];
            }
        }
        
        [this.tagToDia removeObjectForKey:tag];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [this.tagToOperation removeObjectForKey:tag];
        if([this.delegate respondsToSelector:@selector(STUNetRequestErrorByTag:withError:)]){
            [this.delegate STUNetRequestErrorByTag:tag withError:error];
        }
        
        [this.tagToDia removeObjectForKey:tag];
    }];
    
    [[_tagToOperation objectForKey:tag] cancel];
    [_tagToOperation setObject:operation forKey:tag];
    [self.operationQueue addOperation:operation];
}
@end

//        NSClassFromString(@"NSString") != nil
//        EntityUser *user = [[EntityUser alloc] init];
//        [user setValuesForKeysWithDictionary:dict];
