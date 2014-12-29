//
//  UIImage+image.m
//  MJ微博demo
//
//  Created by kang on 14-10-1.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "UIImage+image.h"
//#define iPhone5 ([UIScreen mainScreen].bounds.size.height== 568)

@implementation UIImage (image)

#pragma mark 根据屏幕尺寸返回全屏的图片
+(UIImage *)fullsreenImageWithName:(NSString *)name
{
    if (iPhone5) {
        //new_feature.png
        //new_feature -> new_feature-568@2x
        // new_feature-568@2x.png
        //1获取没有拓展名的文件名
//        NSString *fileName = [name stringByDeletingPathExtension];
//        
//        //2.拼接-568@2x
//        fileName = [fileName stringByAppendingString:@"-568h@2x"];
//        
//        //3.拼接扩展名
//        NSString *extension = [name pathExtension];//获取扩展名
//        name  = [fileName stringByAppendingString:extension];
        
        name = [name fileNameAppend:@"-568h@2x"];
    
        //categreoy之后要定义全局的define 才能使用！
       
    }
    return [UIImage imageNamed:name];
}

+(UIImage *)stretchImaheWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
@end
