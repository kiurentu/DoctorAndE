//
//  shoppingCartGoods.h
//  DoctorAndE
//
//  Created by kang on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

//购物车model

#import <Foundation/Foundation.h>

@interface ShoppingCartGoods : NSObject
@property (nonatomic, copy) NSString *goodsImg; //购物车货品图片
@property (nonatomic, copy) NSString *goodsName; //购物车货品名称
@property (nonatomic, assign) float price; //货品价格
@property (nonatomic, assign) float now_number; //订购数量

@property (nonatomic, assign) BOOL isDelete;
- (id)initWithDict:(NSDictionary *)dic;
@end
