//
//  PullDownMenuProtocol.h
//  DoctorAndE
//
//  Created by SmartGit on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  如果自定义下拉菜单，则实现这两个委托
 *
 *  使用参考moresettingViewController.m类
 */
@protocol PullDownMenuDelegate <NSObject>

@optional

-(NSArray *)customMenu;
-(void)chooseAtIndex:(NSInteger)index;
@end


/**
 *  自定义下拉菜单数据源
 */
@protocol PullDownMenuDataSource <NSObject>

-(NSInteger)numberOfRowsInSection;  //行数
-(NSDictionary *)titleAndImageInIndex:(NSInteger)index; //标题与照片

@end
