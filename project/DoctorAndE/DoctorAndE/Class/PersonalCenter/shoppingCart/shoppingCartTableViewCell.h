//
//  shoppingCartTableViewCell.h
//  DoctorAndE
//
//  Created by kang on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  购物车cell

#import <UIKit/UIKit.h>

@class ShoppingCartGoods;
@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic, strong) ShoppingCartGoods *goodsList;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel; //货物名称
@property (weak, nonatomic) IBOutlet UILabel *priceAndNumLabel; //货物价格及数量
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn; //删除
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg; //货物图像
@property (nonatomic, assign) BOOL isSelect;

@end
