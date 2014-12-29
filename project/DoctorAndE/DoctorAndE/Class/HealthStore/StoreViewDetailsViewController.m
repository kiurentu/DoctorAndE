//
//  StoreViewDetailsViewController.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-25.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#define IMAGE_DETAIL_HIGHT 240  //照片高度
#define COMMENT_CELL_HIGHT 71   //评论高度

#import "StoreViewDetailsViewController.h"
#import "Tools.h"
#import "STUNet.h"
#import "CommodityDetail.h"
#import "UIImageView+WebCache.h"
#import "ImagePageView.h"
#import "CommentTableCell.h"
#import "Comment.h"

@interface StoreViewDetailsViewController ()<STUNetDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) STUNet *stuNet;

@property (nonatomic ,strong) ImagePageView *imagePage;
@property (nonatomic ,strong) CommodityDetail *commodityDetail;

@property (nonatomic ,strong) UITableView *showGood;

@property (nonatomic ,strong) NSMutableArray *commentArray;

@end

@implementation StoreViewDetailsViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"商品详情" withViewController:self];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //默认详细列表
    self.viewKind = detailedIntroduction;
    //添加图片浏览器
    self.imagePage = [ImagePageView instacenView];
    self.imagePage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [self.mainScrollView addSubview:self.imagePage];
    //加载tableView
    self.showGood = [[UITableView alloc]init];
    self.showGood.delegate = self;
    self.showGood.dataSource = self;
    self.showGood.scrollEnabled = NO;
    self.showGood.allowsSelection = NO;
    self.showGood.frame = CGRectZero;
    [self.mainScrollView addSubview:self.showGood];
    
    
    //请求数据
    self.stuNet = [[STUNet alloc]initWithDelegate:self];
    [_stuNet requestTag:@"_CommodityDetail_" andUrl:URL_COMMODITY_DETAIL andBody:@{@"commodityId":self.commodityId}];

    
    //评论选择按钮：默认选中全部
    UIButton *all = [self.buttonArray firstObject];
    all.selected = YES;
    for (UIButton *button in self.buttonArray) {
        [button setTitleColor:[UIColor redColor] forState:
         UIControlStateSelected];
        [button setImage:IMAGE(@"good_more_list_button_icon.png") forState:UIControlStateSelected];
    }
}



-(void)loadDataToView{

    //加载图片浏览器数据
    self.imagePage.imgUrls = self.commodityDetail.pathList;
    
    //加载商品信息
    self.commodityName.text =
        self.commodityDetail.commdityName;
    self.commdityDetail.text =
        self.commodityDetail.commdityDetail;
    
    self.currentPrice.text =
        [NSString stringWithFormat:@"¥ %.2f",self.commodityDetail.currentPrice] ;
    self.originaPrice.text =
        [NSString stringWithFormat:@"¥ %.2f",self.commodityDetail.originaPrice] ;
    self.commdityCode.text =
        self.commodityDetail.commdityCode;
    self.stockQuantity.text =
        [NSString stringWithFormat:@"%d件",self.commodityDetail.stockQuantity];
    self.salesVolume.text =
        [NSString stringWithFormat:@"%d件",self.commodityDetail.salesVolume];
    self.express.text =
        [NSString stringWithFormat:@"¥ %.2f",self.commodityDetail.express];
    
    //调整tableView大小
    CGFloat height = [self.commodityDetail.pathDetailList count]*IMAGE_DETAIL_HIGHT;
    CGFloat screenHeight = 153;
    if (SCREEN_HEIGHT>480) {
        screenHeight = 64;
    }

    self.showGood.frame = CGRectMake(0, CGRectGetMaxY(self.tabControlView.frame), SCREEN_WIDTH, height);
    //调整主ScrollView大小
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    //NSLog(@"%f",CGRectGetMaxY(self.tabControlView.frame));
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.tabControlView.frame) + height+screenHeight);
    
}

/**
 *  转换评论和详细按钮
 *
 *  @param sender 当前Button
 */
- (IBAction)clicksliderButton:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"详细介绍"]) {

        [UIView animateWithDuration:0.3 animations:^{
            self.slideLine.center = CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame));
        }];
        CGFloat height = [self.commodityDetail.pathDetailList count]*IMAGE_DETAIL_HIGHT;
        self.showGood.frame = CGRectMake(0, CGRectGetMaxY(self.tabControlView.frame), SCREEN_WIDTH, height);
        
        self.viewKind = detailedIntroduction;
        [self.showGood reloadData];
        
    }else if ([sender.currentTitle isEqualToString:@"评价"]){
        
        [UIView animateWithDuration:0.3 animations:^{
            self.slideLine.center = CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame));
        }];
        
        self.viewKind = evaluateIntroduction;
        //请求首页数据
        [self loadCommdityComment:1];

    }
}


/**
 *  转换评价选项
 *
 *  @param sender 当前Button
 */
-(IBAction)clickEvaluateButton:(UIButton *)sender{
    
    NSInteger buttonIndex = [self.buttonArray indexOfObject:sender];

    for (UIButton *button in self.buttonArray) {
        if (button.selected && ![button isEqual:sender]) {
            button.selected = NO;

        }
    }
    sender.selected = YES;

    switch (buttonIndex) {
        case 0:
            NSLog(@"全部");
            [self loadCommdityComment:0];
            
            break;
        case 1:
             NSLog(@"好评");
            [self loadCommdityComment:1];
            
            break;
        case 2:
             NSLog(@"中评");
            [self loadCommdityComment:2];
            
            break;
        case 3:
             NSLog(@"差评");
            [self loadCommdityComment:3];
            
            break;
        default:
            break;
    }
    
}

#pragma  mark -- STUNetDelegate
-(void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic{
    //NSLog(@"%@",dic);
    
    if (dic && [tag isEqualToString:@"_CommodityDetail_"]) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setDictionary:[dic objectForKey:@"commodityDetails"]];
        [tempDic setObject:[dic objectForKey:@"pathDetailList"] forKey:@"pathDetailListArray"];
        [tempDic setObject:[dic objectForKey:@"pathList"] forKey:@"pathListArray"];

        self.commodityDetail = [[CommodityDetail alloc]initWithDictionary:tempDic];

        
        [self loadDataToView];

    }else if (dic && [tag isEqualToString:@"_CommodityComment_"]){
        NSLog(@"%@",dic);
        self.commentArray = [NSMutableArray array];
        NSArray *list = [dic objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            Comment *comment = [[Comment alloc]initWithDictionary:dic];
            [self.commentArray addObject:comment];
        }
        
        [UIView animateWithDuration:0 animations:^{
            self.showGood.frame = CGRectMake(0, CGRectGetMaxY(self.evaluateView.frame), SCREEN_WIDTH, [self.commentArray count]*COMMENT_CELL_HIGHT);
        }];
        [self.showGood reloadData];

    }

}
/**
 *  请求评论数据
 *
 *  @param pageNum 请求页数
 */
-(void)loadCommdityComment:(NSInteger )pageNum{
  
    
    NSNumber *nsNum = [NSNumber numberWithInteger:pageNum];
    NSDictionary *strBody = @{@"pageSize":@10,@"pageNum":nsNum,@"type":@"1",@"supplyId":self.commodityId};
    [_stuNet requestTag:@"_CommodityComment_" andUrl:URL_COMMODITY_COMMENT andBody:strBody];
    
    
}

#pragma mark -- UITableViewDataSource
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewKind == detailedIntroduction) {
        return [self.commodityDetail.pathDetailList count];
    }else if (self.viewKind == evaluateIntroduction){
        return [self.commentArray count];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewKind == detailedIntroduction) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailCell"];
        NSInteger row = [indexPath row];
        NSString *urlString = self.commodityDetail.pathDetailList[row];
        NSURL *url = [NSURL URLWithString:urlString];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IMAGE_DETAIL_HIGHT)];
        [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        cell.backgroundView = imageView;
        
        return cell;
    }else if (self.viewKind == evaluateIntroduction){
        CommentTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CommentTableCell" owner:self options:nil];
        cell = [nibs lastObject];
        Comment *comment = self.commentArray[indexPath.row];
        [cell.userPicture sd_setImageWithURL:comment.userPicture];
        cell.userName.text = comment.userName;
        //cell.grade.text = comment.grade;
        cell.comment.text = comment.comment;
        cell.date.text = comment.date;
        
        return cell;
    }else{
        
        return nil;
    }
}

#pragma  mark -- UITableViewDelegate

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewKind == detailedIntroduction) {
        return IMAGE_DETAIL_HIGHT;
    }else if (self.viewKind == evaluateIntroduction){
        return COMMENT_CELL_HIGHT;
    }else{
        return 0;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
