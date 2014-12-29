//
//  IDtestViewController.h
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

@protocol IDtesDelegate<NSObject>//图片上传成功后执行的协议

-(void)upLoadImg;

@end

#import <UIKit/UIKit.h>

//身份认证的类型：1主账号身份认证 2.亲友身份认证
typedef enum{
    IdTypeUser = 1,
    IdTypeMember
}IdType;

@interface IDtestViewController : UIViewController

@property(nonatomic,copy)NSString *trueName;//名字
@property(nonatomic,copy)NSString *sfzh;//身份证号
@property(nonatomic,copy)NSString *Id;//用户id或亲友id
@property(nonatomic,assign) IdType idType;//身份认证的类型：1主账号身份认证 2.亲友身份认证
@property(nonatomic,weak)id<IDtesDelegate>delegate;//使用代理传值



@end
