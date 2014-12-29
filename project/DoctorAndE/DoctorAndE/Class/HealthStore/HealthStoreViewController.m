//
//  HealthStoreViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

NSString *const CellIdentiferId = @"TagStoreCollectionCell";

#define ITEM_BUTTON_WIDTH 40
#define COLLECTION_CELL_SIZE 97

#import "HealthStoreViewController.h"
#import "App.h"
#import "StoreCollectionCell.h"
#import "Commodity.h"
#import "UIImageView+WebCache.h"
#import "FFScrollView.h"
#import "STUNet.h"
#import "MoreShoppingViewController.h"
#import "RollViewDetailsViewController.h"
#import "StoreViewDetailsViewController.h"

@interface HealthStoreViewController ()<STUNetDelegate,FFScrollViewDelegate>

@property (nonatomic ,strong) STUNet *stuNet;
@property (nonatomic ,strong) NSMutableArray *listArray;

@property (nonatomic ,strong) NSArray *rollViewArray;

@end

@implementation HealthStoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

    //请求数据
    [self loadDatafromDatabase];
    
    //添加navigationItem
    [self addNavigationItemButton];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    //滚动视图
    self.ffScrollView = [[FFScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 159)];
    self.ffScrollView.pageViewDelegate = self;
    [self.view addSubview:self.ffScrollView];
    
    //更多按钮
    [self.moreButton setBackgroundImage:IMAGE(@"more_button_pressed.png") forState:UIControlStateHighlighted];
    [self.moreButton addTarget:self action:@selector(moreShoppingShowView) forControlEvents:UIControlEventTouchUpInside];
    
    //加载UICollectionView
    [self.shopView registerNib:
                    [UINib nibWithNibName:@"StoreCollectionCell" bundle:nil]
                    forCellWithReuseIdentifier:CellIdentiferId];
    self.shopView.scrollEnabled = YES;
    self.shopView.backgroundColor = [UIColor clearColor];
    self.shopView.alwaysBounceVertical = YES;
    self.shopView.showsVerticalScrollIndicator = NO;
    //解决IOS7下collectionView顶部留白
    if (IOS7){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
}

-(void)loadDatafromDatabase{
    self.stuNet = [[STUNet alloc]initWithDelegate:self];
    
    //数据请求body
    NSDictionary *dic = @{@"pageSize":@9,@"pageNum":@0,@"type":@1,@"allType":@1,@"allId":@""};
    [_stuNet requestTag:@"_MainHealthShop_" andUrl:URL_MAIN_HEALTHSHOP andBody:dic];
    
    [_stuNet requestTag:@"_FFScrollView_" andUrl:URL_SCROLLVIEW_SHOP andBody:@{}];
}


-(void)addNavigationItemButton{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, ITEM_BUTTON_WIDTH)];
    label.text = @"健康商城";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:label];
    
    UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopButton.frame = CGRectMake(0, 0, ITEM_BUTTON_WIDTH, ITEM_BUTTON_WIDTH);
    [shopButton setBackgroundImage:IMAGE(@"shape-354.png") forState:UIControlStateNormal];
    [shopButton addTarget:self action:@selector(MyShoppingCar) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shopingCarItem = [[UIBarButtonItem alloc]initWithCustomView:shopButton];
    shopingCarItem.tintColor = [UIColor whiteColor];
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake(0, 0, ITEM_BUTTON_WIDTH, ITEM_BUTTON_WIDTH);
    [orderButton setBackgroundImage:IMAGE(@"navbar_ic订单.png") forState:UIControlStateNormal];
    [orderButton addTarget:self action:@selector(MyOrderForm) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *orderFromItem = [[UIBarButtonItem alloc]initWithCustomView:orderButton];
    orderFromItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItems = @[shopingCarItem,orderFromItem];
}


#pragma mark -- UICollectionViewDataSource

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.listArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentiferId forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    
    Commodity *commodity = [self.listArray objectAtIndex:row];
    
    [cell.commodityImage sd_setImageWithURL:
                            commodity.thumLogo
                            placeholderImage:IMAGE(@"targe.png")
                            options:SDWebImageRefreshCached];

    cell.commodityLabel.text =[NSString stringWithFormat:@"¥ %.2f",commodity.currentPrice];
    cell.titleLabel.text = commodity.CommdityName;
    
    return cell;
    
}

#pragma mark -- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(COLLECTION_CELL_SIZE, COLLECTION_CELL_SIZE);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewDetailsViewController *storeViewDetails = [[StoreViewDetailsViewController alloc]init];
    
    Commodity *commdity = self.listArray[indexPath.row];
    storeViewDetails.commodityId = commdity.commodityId;
    [self.navigationController pushViewController:storeViewDetails animated:YES];
    
}

#pragma mark -- STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString*) tag withDic:(NSDictionary*)dic{
    //NSLog(@"%@",dic);
    
    //商品列表
    if (dic && [tag isEqualToString:@"_MainHealthShop_"]) {
        NSArray *array = [dic objectForKey:@"list"];
        self.listArray = [NSMutableArray array];
        
        for (NSDictionary *d in array) {
            Commodity *commodity = [[Commodity alloc]initWithDictionary:d];
            [self.listArray addObject:commodity];
        }
        
        [self.shopView reloadData];
        
    }
    //滚动视图
    if (dic && [tag isEqualToString:@"_FFScrollView_"]) {
        self.rollViewArray = [dic objectForKey:@"list"];
        
        NSMutableArray *arrayImage = [NSMutableArray array];
        for (NSDictionary *d in self.rollViewArray) {
            NSString *image = [d objectForKey:@"picAddress"];
            [arrayImage addObject:image];
        }
        [self.ffScrollView PageViewWithInformationArray:arrayImage];
    }

}


#pragma mark -- FFScrollViewDelegate
- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber{
    
    NSLog(@"点击了%d",pageNumber);
    
    RollViewDetailsViewController *rollView = [[RollViewDetailsViewController alloc]init];
    rollView.detailDic = [self.rollViewArray objectAtIndex:pageNumber];

    [self.navigationController pushViewController:rollView animated:YES];
}
/**
 *  我的订单
 */
-(void)MyOrderForm{
    
}
/**
 *  我的购物车
 */
-(void)MyShoppingCar{
    
}

/**
 *  展示更多
 */
-(void)moreShoppingShowView{
    MoreShoppingViewController *moreShoppingViewController = [[MoreShoppingViewController alloc]init];
    
    [self.navigationController pushViewController:moreShoppingViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
