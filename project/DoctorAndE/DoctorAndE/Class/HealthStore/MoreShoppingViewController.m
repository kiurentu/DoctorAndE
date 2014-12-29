//
//  MoreShoppingViewController.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-22.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

NSString *const CellIdentiferTable = @"TagStoreTableCell";
NSString *const CellIdentiferCollection = @"TagStoreCollectionCell";

#import "MoreShoppingViewController.h"
#import "StoreTableCell.h"
#import "MJRefresh.h"
#import "Commodity.h"
#import "UIImageView+WebCache.h"
#import "StoreCollectionCell.h"
#import "STUNet.h"
#import "Tools.h"
#import "StoreViewDetailsViewController.h"

@interface MoreShoppingViewController ()<STUNetDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSInteger pageCount;    //总页数
    NSInteger referCount;   //加载次数
}

@property (nonatomic ,strong) STUNet *stuNet;

@property (nonatomic ,strong) UIButton *button;
@property (nonatomic ,strong) NSMutableArray *filteredArray;
@end

@implementation MoreShoppingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"商品列表" withViewController:self];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //加载UI
    [self loadCurrentViewUI];
    //加载刷新功能
    [self setupRefresh];
    
}


/**
 *  请求数据
 *
 *  @param pageNum 请求页数
 */
-(void)loadDatafromDatabase:(NSInteger )pageNum{
    self.stuNet = [[STUNet alloc]initWithDelegate:self];
    
    NSNumber *page = [NSNumber numberWithInteger:pageNum];
    //数据请求body
    NSDictionary *dic = @{@"pageSize":@10,@"pageNum":page,@"type":@1,@"allType":@1,@"allId":@""};
    [_stuNet requestTag:@"_MoreHealthShop_" andUrl:URL_MORE_HEALTHSHOP andBody:dic];
}


-(void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic{
    
    if (dic && [tag isEqualToString:@"_MoreHealthShop_"]) {
        NSArray *array = [dic objectForKey:@"list"];
        self.moreShoppingArray = [NSMutableArray array];
        
        for (NSDictionary *d in array) {
            Commodity *commodity = [[Commodity alloc]initWithDictionary:d];
            [self.moreShoppingArray addObject:commodity];
        }
        pageCount = [[dic objectForKey:@"pageCount"]integerValue];
        [self.moreTableView reloadData];
        [self.moreCollectionView reloadData];
        
        //结束刷新
        [self.moreCollectionView headerEndRefreshing];
        [self.moreCollectionView footerEndRefreshing];
        [self.moreTableView headerEndRefreshing];
        [self.moreTableView footerEndRefreshing];
    }
}

/**
 *  加载UI
 */
-(void)loadCurrentViewUI{

    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 20, 20);
    [self.button setBackgroundImage:IMAGE(@"good_more_list_button_icon.png") forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(ConversionView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tranfromBtn = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    [self.navigationItem addRightBtn:tranfromBtn];
    
    //加载UITableView
    [self.moreTableView registerNib:[UINib nibWithNibName:@"StoreTableCell" bundle:nil] forCellReuseIdentifier:CellIdentiferTable];
    //self.moreTableView.allowsSelection = NO;
    [self.moreTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.moreTableView setSeparatorColor:[UIColor lightGrayColor]];
    if (IOS7) {
        [self.moreTableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }

    
    //加载UICollectionView
    [self.moreCollectionView registerNib:[UINib nibWithNibName:@"StoreCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentiferCollection];
    self.moreCollectionView.backgroundColor = [UIColor clearColor];
    self.moreCollectionView.alwaysBounceVertical = YES;
    self.viewKind = ViewKindUITableView;
    self.serchstate = ViewSearchStateNO;
    self.moreCollectionView.hidden = YES;
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    //TableView上下拉
    [self.moreTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.moreTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.moreTableView headerBeginRefreshing];
    
    //CollcetionView上下拉
    [self addCollectionViewHeaderRefresh];
    [self addCollectionViewFooterRefresh];
    
}

// 添加下拉刷新头部控件
- (void)addCollectionViewHeaderRefresh
{

    [self.moreCollectionView addHeaderWithCallback:^{
        
        NSLog(@"下拉刷新");
        referCount = 0;
        [self loadDatafromDatabase:referCount];
        
    }];
    
}

// 添加上拉刷新尾部控件
- (void)addCollectionViewFooterRefresh
{

    [self.moreCollectionView addFooterWithCallback:^{

        referCount++;
        if (referCount <= pageCount) {
            NSLog(@"上拉加载");
            [self loadDatafromDatabase:referCount];
        }else{
            NSLog(@"已没有更多数据");
            [Tools showMessage:@"已没有更多数据"];
            [self.moreCollectionView footerEndRefreshing];
        }

    }];
}

-(void)headerRereshing{
    
    
    NSLog(@"下拉刷新");
    referCount = 0;
    [self loadDatafromDatabase:referCount];
}

-(void)footerRereshing{
    
    referCount++;
    if (referCount <= pageCount) {
        NSLog(@"上拉加载");
        [self loadDatafromDatabase:referCount];
    }else{
        NSLog(@"已没有更多数据");
        [Tools showMessage:@"已没有更多数据"];
        [self.moreTableView footerEndRefreshing];
    }

}



/**
 *  切换TableView和CollectionView
 */
-(void)ConversionView{
    if(self.viewKind == ViewKindUITableView){
        
        [self.moreCollectionView headerBeginRefreshing];
        self.moreTableView.hidden = YES;
        self.moreCollectionView.hidden = NO;
        self.viewKind = ViewKindUICollectionView;
        [self.button setBackgroundImage:IMAGE(@"good_more_button_icon.png") forState:UIControlStateNormal];
    }else{
        
        [self.moreTableView headerBeginRefreshing];
        self.moreTableView.hidden = NO;
        self.moreCollectionView.hidden = YES;
        self.viewKind = ViewKindUITableView;
        [self.button setBackgroundImage:IMAGE(@"good_more_list_button_icon.png") forState:UIControlStateNormal];
    }
}


#pragma mark -- UITableViewDataSource
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.serchstate == ViewSearchStateNO){
        return [self.moreShoppingArray count];
    }else if (self.serchstate == ViewSearchStateYES){
        return [self.filteredArray count];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferTable forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSInteger row = [indexPath row];

    Commodity *commodity;
    if(self.serchstate == ViewSearchStateNO){
        commodity = [self.moreShoppingArray objectAtIndex:row];
    }else if (self.serchstate == ViewSearchStateYES){
        commodity = [self.filteredArray objectAtIndex:row];
    }else{
        commodity = nil;
    }
    
    [cell.sImageView sd_setImageWithURL:commodity.thumLogo placeholderImage:IMAGE(@"targe.png") options:SDWebImageRefreshCached];
    cell.titleLabel.text = commodity.CommdityName;
    cell.sellLabel.text = [NSString stringWithFormat:@"%d件",commodity.salesVolume];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",commodity.currentPrice];

    
    return cell;
}


#pragma mark -- UITableViewDelegate
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewDetailsViewController *storeViewDetails = [[StoreViewDetailsViewController alloc]init];
    
    Commodity *commdity;
    if(self.serchstate == ViewSearchStateNO){
        commdity = self.moreShoppingArray[indexPath.row];
        
    }else if (self.serchstate == ViewSearchStateYES){
        commdity = self.filteredArray[indexPath.row];
    }
    storeViewDetails.commodityId = commdity.commodityId;
    [self.navigationController pushViewController:storeViewDetails animated:YES];
}


#pragma mark -- UICollectionViewDataSource
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(self.serchstate == ViewSearchStateNO){
        return [self.moreShoppingArray count];
    }else if (self.serchstate == ViewSearchStateYES){
        return [self.filteredArray count];
    }else{
        return 0;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentiferCollection forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    Commodity *commodity;
    if(self.serchstate == ViewSearchStateNO){
        commodity = [self.moreShoppingArray objectAtIndex:row];
    }else if (self.serchstate == ViewSearchStateYES){
        commodity = [self.filteredArray objectAtIndex:row];
    }else{
        commodity = nil;
    }
    
    
    [cell.commodityImage sd_setImageWithURL:commodity.thumLogo placeholderImage:IMAGE(@"targe.png") options:SDWebImageRefreshCached];
    
    cell.commodityLabel.text =[NSString stringWithFormat:@"¥ %.2f",commodity.currentPrice];
    cell.titleLabel.text = commodity.CommdityName;
    return cell;
    
    
}

#pragma mark -- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(140, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewDetailsViewController *storeViewDetails = [[StoreViewDetailsViewController alloc]init];
    Commodity *commdity;
    if(self.serchstate == ViewSearchStateNO){
        commdity = self.moreShoppingArray[indexPath.row];
       
    }else if (self.serchstate == ViewSearchStateYES){
        commdity = self.filteredArray[indexPath.row];
    }
     storeViewDetails.commodityId = commdity.commodityId;
    [self.navigationController pushViewController:storeViewDetails animated:YES];
}

- (IBAction)searchTheCommodityAndView {
    [self.filteredArray removeAllObjects];
    //NSLog(@"%@",self.searchTextField.text);
    
    if(self.searchTextField && self.searchTextField.text.length>0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchTextField.text];
        [self.moreShoppingArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            Commodity *commodity = (Commodity *)obj;
            if([predicate evaluateWithObject:commodity.CommdityName]){
                [self.filteredArray addObject:commodity];
            }
        }];
        
    }
    self.serchstate = ViewSearchStateYES;
    
    [self.searchTextField resignFirstResponder];
    [self.moreTableView reloadData];
    [self.moreCollectionView reloadData];
}

-(NSMutableArray *)filteredArray{
    if(!_filteredArray){
        _filteredArray = [[NSMutableArray alloc]init];
    }
    return _filteredArray;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
