//
//  PullDownMenu.h
//  DoctorAndE
//
//  Created by SmartGit on 14-11-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

typedef NS_ENUM(NSInteger, ItemMeun) {
    ItemMenuHide,
    ItemMenuShow
    
};//菜单是否展开


#import <UIKit/UIKit.h>
#import "PullDownMenuProtocol.h"

@interface PullDownMenu : UIView<UITableViewDataSource,UITableViewDelegate>
    
@property (nonatomic ,weak) id<PullDownMenuDelegate> menuDelegate;
@property (nonatomic ,weak) id<PullDownMenuDataSource> menuDataSource;

@property (nonatomic ,assign) ItemMeun item;    //菜单状态

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIView *backgroundView;   //灰色背景

-(void)hideChooseListView;  //显示菜单
-(void)showChooseListView;  //隐藏菜单

/**
 *  下拉菜单实例化方法
 *
 *  @param frame      视图大小
 *  @param datasource 数据源，非自定义传"nil"
 *  @param delegate   委托，非自定义传"nil"
 *
 *  @return self
 */
- (id)initWithNavigateContoller:(UINavigationController *)naviagte dataSource:(id)datasource delegate:(id) delegate;
@end
