//
//  NSString+file.m
//  MJ微博demo
//
//  Created by kang on 14-10-1.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "NSString+file.h"

@implementation NSString (file)

-(NSString *)fileNameAppend:(NSString *)append{
    
   
    //1获取没有拓展名的文件名
    NSString *fileName = [self stringByDeletingPathExtension];
    
    //2.拼接-568@2x
    fileName = [fileName stringByAppendingString:append];
    
    //3.拼接扩展名
    NSString *extension = [self pathExtension];//获取扩展名
    
    return [fileName stringByAppendingString:extension];

}

-(NSString *)NameAppendHLight:(NSString *)append{
    
    NSArray *array = [append componentsSeparatedByString:@"_"];
    NSMutableArray *muArr = [[NSMutableArray alloc]initWithArray:array];
    [muArr removeLastObject];
    NSString *string = [muArr componentsJoinedByString:@"_"];
    NSString *fileName = [string stringByAppendingString:@"_normal.png"];
    
    return fileName;
}

@end
