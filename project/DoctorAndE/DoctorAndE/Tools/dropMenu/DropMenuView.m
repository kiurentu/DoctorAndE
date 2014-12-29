//
//  DropMenuView.m
//  ManyButton
//
//  Created by UI08 on 14-11-5.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import "DropMenuView.h"
#import "DropMenuCell.h"

@interface DropMenuView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    CGRect _frame;
    UITableView *_tableView;
    NSArray *_arr;
    UIButton *_btn;
    NSString *_imageName;
    UIViewController *_vec;
    
}
@end

@implementation DropMenuView

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)arr withImage:(NSString *)imageName withviewController:(UIViewController *)viewController
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _arr = arr;
        _imageName = imageName;
        _frame = frame;
        _vec = viewController;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate =self;
        [viewController.view addGestureRecognizer:tap];
        
        self.frame = CGRectMake(frame.origin.x,frame.origin.y+20, frame.size.width, frame.size.height);

        self.menuType = MenuTypeClose;
        [self initMenu];
        [self initTableView];

    }
    
    return self;
    
}

-(void)tap
{
    [_vec.view endEditing:YES];
    _tableView.hidden = YES;
    self.frame = CGRectMake(_frame.origin.x, _frame.origin.y+20, _frame.size.width, _frame.size.height);
    self.menuType = MenuTypeClose;

}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{

    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

-(void)initMenu
{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setImage:[UIImage imageNamed:_imageName] forState:UIControlStateNormal];
    _btn.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
    [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}

-(void)initTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.hidden = YES;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0, _frame.size.height, _frame.size.width, _frame.size.height * _arr.count+1);
    [self addSubview:_tableView];

}

-(void)click
{
    if (self.menuType == MenuTypeClose) {
        
        self.frame = CGRectMake(_frame.origin.x,_frame.origin.y+20,_frame.size.width , _frame.size.height*(_arr.count+1)+1);
        _tableView.hidden = NO;
        self.menuType = MenuTypeOpen;
        
    }else{
        _tableView.hidden = YES;
        self.frame = CGRectMake(_frame.origin.x, _frame.origin.y+20, _frame.size.width, _frame.size.height);;
        self.menuType = MenuTypeClose;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    DropMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[DropMenuCell ID]];
    if (cell == nil) {
        cell = [[DropMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[DropMenuCell ID]];
        
        cell.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
        cell.menuLabel.frame = CGRectMake(5, 0, _frame.size.width, _frame.size.height);

    }
    
    cell.menuLabel.text = _arr[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.menuType = MenuTypeClose;
    _tableView.hidden = YES;
    self.frame = CGRectMake(_frame.origin.x, _frame.origin.y+20, _frame.size.width, _frame.size.height);
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickMenu:)]) {
        [_delegate clickMenu:_arr[indexPath.row]];
    }
    
    if (_menuBlock ) {
        _menuBlock(_arr[indexPath.row]);
    }
    
}

@end
