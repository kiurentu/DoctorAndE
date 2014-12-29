//
//  shoppingCartTableViewCell.m
//  DoctorAndE
//
//  Created by kang on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartGoods.h"
@implementation ShoppingCartTableViewCell


- (void)awakeFromNib {
	self.priceAndNumLabel.text = [NSString stringWithFormat:@"价格：%.0f 数量:%.0f件", self.goodsList.price, self.goodsList.now_number];


	self.goodsNameLabel.text = self.goodsList.goodsName;
}

- (void)setIsSelect:(BOOL)isSelect {
	_isSelect = isSelect;
	if (_isSelect == YES) {
		self.selectImg.image = [UIImage imageNamed:@"searchbar_popup_box_circle_pressed.png"];
	}
	else {
		self.selectImg.image = [UIImage imageNamed:@"searchbar_popup_box_circle_normal.png"];
	}
}

- (void)setGoodsList:(ShoppingCartGoods *)goodsList {
	_goodsList = goodsList;

	self.priceAndNumLabel.text = [NSString stringWithFormat:@"价格：%.0f 数量:%.0f件", goodsList.price, goodsList.now_number];
	self.goodsNameLabel.text = goodsList.goodsName;
	self.goodsImg.image = [UIImage imageNamed:goodsList.goodsImg];
	self.selectImg.image = goodsList.isDelete ? [UIImage imageNamed:@"searchbar_popup_box_circle_pressed.png"] : [UIImage imageNamed:@"searchbar_popup_box_circle_normal.png"];
}

@end
