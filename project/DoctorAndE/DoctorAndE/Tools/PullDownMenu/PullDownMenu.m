//
//  PullDownMenu.m
//  DoctorAndE
//
//  Created by SmartGit on 14-11-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//


#define CELL_HEIGHT  45     //tableViewCell的高度
#define CELL_WIDTH   120    //tableViewCell宽度

#import "PullDownMenu.h"
#import "TabBarViewController.h"

@interface PullDownMenu()

@property (nonatomic ,strong) NSArray *defaulTitle;   //默认
@property (nonatomic ,strong) UINavigationController *navController;
@end


@implementation PullDownMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 *  初始化下拉列表
 *
 *  @param frame     整个视图frame
 *  @param title     字典数组
 *
 *  @return self
 */

- (id)initWithNavigateContoller:(UINavigationController *)naviagte dataSource:(id)datasource delegate:(id) delegate{
    self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
    if (self) {
        
        self.item = ItemMenuHide;   //默认隐藏
        self.menuDelegate = delegate;
        self.menuDataSource = datasource;
        self.navController = naviagte;
        
        self.frame = CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
  
    }
    
    return self;
}

/**
 *  默认数据源
 *
 *  @return array
 */
-(NSArray *)defaulTitle{
    if (!_defaulTitle) {
        _defaulTitle = @[
          @{@"title":@"首页",@"image":@"navbar_ic首页"},
//          @{@"title":@"医疗中心",@"image":@"navbar_ic医疗中心"},
          @{@"title":@"健康商城",@"image":@"navbar_ic健康商城"},
          @{@"title":@"应用中心",@"image":@"navbar_ic应用中心"},
          @{@"title":@"个人中心",@"image":@"navbar_ic个人中心"}];
    }
    return _defaulTitle;
}

/**
 *  显示下拉列表
 */
-(void)showChooseListView{
    
    self.item = ItemMenuShow;

    NSInteger row;
    if ([self.menuDelegate respondsToSelector:@selector(customMenu)]) {
        row = [self.menuDataSource numberOfRowsInSection];
    }else{
        row = [self.defaulTitle count];
    }
    
    if (!_tableView) {
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-63)];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];

        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CELL_WIDTH, 0, CELL_WIDTH, CELL_HEIGHT*row) style:UITableViewStylePlain];
        if (SYSTERM_VERSION > 6.0) {
            self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //添加手势
        UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BackgroundTapTappedAction:)];
        [self.backgroundView addGestureRecognizer:backgroundTap];
    }
    
    //创建动画
    CGRect rect = self.tableView.frame;
    rect.size.height = 0;
    self.tableView.frame = rect;
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.tableView];
    
    rect.size.height = CELL_HEIGHT*row;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.2;
        self.tableView.alpha = 0.2;
        
        self.alpha = 1.0;
        self.tableView.alpha = 1.0;
        
        self.tableView.frame = rect;
    }];
    
}

/**
 *  隐藏下拉列表
 */
-(void)hideChooseListView{
    
    self.item = ItemMenuHide;
    CGRect rect = _tableView.frame;
    rect.size.height = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self.tableView.alpha = 1.0;
        
        self.alpha = 0.2;
        self.tableView.alpha = 0.2;
        
        self.tableView.frame = rect;

    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];

    }];
    
}


-(void)BackgroundTapTappedAction:(UITapGestureRecognizer *)tap{
    
    [self hideChooseListView];
}


#pragma mark -- UITableViewDataSource

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.menuDelegate respondsToSelector:@selector(customMenu)]) {
        return [self.menuDataSource numberOfRowsInSection];
    }else{
        return [self.defaulTitle count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"NavigationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSInteger rowCount = [indexPath row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    }
    NSDictionary *text;
    //自定义菜单
    if ([self.menuDelegate respondsToSelector:@selector(customMenu)]) {
        
        text = [self.menuDataSource titleAndImageInIndex:rowCount];
        
    }else{
        
    //默认菜单
        text = [self.defaulTitle objectAtIndex:rowCount];
    
    }
    
    UIView *normalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEIGHT)];
    normalView.backgroundColor = [UIColor clearColor];
    
    UIImageView *normalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 11, 23, 23)];
    normalImageView.image = IMAGE([text objectForKey:@"image"]);
    [normalView addSubview:normalImageView];

    UILabel *normalLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 13, 80, 20)];
    normalLabel.textColor = [UIColor darkGrayColor];
    normalLabel.text = [text objectForKey:@"title"];
    [normalView addSubview:normalLabel];
    
    cell.backgroundView = normalView;
    
    //点击后
    UIView *pressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEIGHT)];
    pressView.backgroundColor = RGBCOLOR(20, 116, 166);
    UILabel *pressLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 13, 80, 20)];
    pressLabel.textColor = [UIColor whiteColor];
    pressLabel.text = [text objectForKey:@"title"];
    [pressView addSubview:pressLabel];
    
    UIImageView *pressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 11, 23, 23)];
    NSString *imageName =[NSString stringWithFormat:@"%@pressed",[text objectForKey:@"image"]];
    pressImageView.image = IMAGE(imageName);
    [pressView addSubview:pressImageView];
    
    cell.selectedBackgroundView = pressView;

    
    return cell;
}



#pragma mark -- UITabelViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger rowCount = [indexPath row];

    //自定义菜单
    if ([self.menuDelegate respondsToSelector:@selector(customMenu)]) {
        
        [self.menuDelegate chooseAtIndex:rowCount];
    }else{

    //默认菜单
        [self.navController popToRootViewControllerAnimated:NO];
        [TabBarViewController notificationSelectIndex:rowCount];

    }
    [self hideChooseListView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELL_HEIGHT;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end