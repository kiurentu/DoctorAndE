//
//  shoppingCartViewController.m
//  DoctorAndE
//
//  Created by kang on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//购物车

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartGoods.h"
#import "Tools.h"
@interface ShoppingCartViewController () <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableArray *_goodsListArray;
	NSMutableArray *_deleteGoodsListArray;
	NSArray *_data;
	NSMutableArray *_selectListArray;
	BOOL isAllSelect;
	NSString *_addNumber;
}
@end

@implementation ShoppingCartViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"购物车" withViewController:self];
    //假数据,修改时可删除
	//加载more.plist
	NSURL *url =  [[NSBundle mainBundle] URLForResource:@"shopCart" withExtension:@"plist"];
	_data = [NSDictionary dictionaryWithContentsOfURL:url][@"model"];



	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.view.backgroundColor = kGlobalBg;

	_selectListArray = [NSMutableArray array];
	_goodsListArray = [NSMutableArray array];
	_deleteGoodsListArray = [NSMutableArray array];
	isAllSelect = NO;
	for (NSDictionary *dict in _data) {
		ShoppingCartGoods *s = [[ShoppingCartGoods alloc]initWithDict:dict];
		[_goodsListArray addObject:s];
	}
	if (iPhone5) {
		if (_goodsListArray.count <= 4) {
			self.tableView.scrollEnabled = NO;
		}
	}
	else {
		if (_goodsListArray.count <= 3) {
			self.tableView.scrollEnabled = NO;
		}
	}

	[self.AllSelectBtn addTarget:self action:@selector(AllSelect) forControlEvents:UIControlEventTouchUpInside];
}

//全选按钮的Action
- (void)AllSelect {
	self.AllSelectBtn.selected = !self.AllSelectBtn.selected;
	isAllSelect = self.AllSelectBtn.selected;
	[self.tableView reloadData];
	if (isAllSelect) {
		float number = 0;
		for (ShoppingCartGoods *googds in _goodsListArray) {
			googds.isDelete = YES;
			number += googds.price * googds.now_number;
		}
		_addNumber = [NSString stringWithFormat:@"￥%.1f", number];
	}
	else {
		for (ShoppingCartGoods *googds in _goodsListArray) {
			googds.isDelete = NO;
		}
		_addNumber = @"￥0.0";
	}
	if (isAllSelect == YES) {
		[_selectListArray addObjectsFromArray:_goodsListArray];
	}
	else if (isAllSelect == NO) {
		[_selectListArray removeAllObjects];
	}


	_totalLabel.text = _addNumber;
}

#pragma mark UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _goodsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ShoppingCartTableViewCell";
	ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil]lastObject];
	}


	cell.goodsList = _goodsListArray[indexPath.row];


	cell.deleteBtn.tag = indexPath.row;
	[cell.deleteBtn addTarget:self action:@selector(deleteMothed:) forControlEvents:UIControlEventTouchUpInside];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 98;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ShoppingCartTableViewCell *cell = (ShoppingCartTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	cell.goodsList = [_goodsListArray objectAtIndex:indexPath.row];

	cell.goodsList.isDelete = !cell.goodsList.isDelete;

	cell.isSelect = cell.goodsList.isDelete;
   // cell选择逻辑处理
	if (cell.isSelect == YES) {
		[_selectListArray addObject:[_goodsListArray objectAtIndex:indexPath.row]];
	}
	if (cell.isSelect == NO) {
		[_selectListArray removeObject:[_goodsListArray objectAtIndex:indexPath.row]];
	}
	if (_selectListArray.count == _goodsListArray.count) {
		self.AllSelectBtn.selected = YES;
	}
	if (cell.isSelect == NO) {
		self.AllSelectBtn.selected = NO;
	}


	ShoppingCartGoods *s = [[ShoppingCartGoods alloc]init];
	float addNumber = 0;
	for (int i = 0; i < _selectListArray.count; i++) {
		s = _selectListArray[i];
		addNumber += s.price * s.now_number;
	}
	_addNumber = [NSString stringWithFormat:@"￥%.1f", addNumber];

	_totalLabel.text = _addNumber;
}

//删除按钮的action方法
- (void)deleteMothed:(UIButton *)btn {
	[_deleteGoodsListArray addObject:[_goodsListArray objectAtIndex:btn.tag]];
	if (_deleteGoodsListArray != 0) {
		[_goodsListArray removeObjectsInArray:_deleteGoodsListArray];
	}
	self.AllSelectBtn.selected = YES;
	[self AllSelect];
	[self.tableView reloadData];
}

- (void)exitClick:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
