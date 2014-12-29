//
//  MoreShoppingViewController.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-22.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

typedef NS_ENUM(NSInteger, CurrentViewKind) {
    ViewKindUITableView = 1,    //默认
    ViewKindUICollectionView
    
};//视图类型

typedef NS_ENUM(NSInteger, ViewSearchState) {
    ViewSearchStateNO = 10,     //默认
    ViewSearchStateYES
    
};//是否检索

#import <UIKit/UIKit.h>

@interface MoreShoppingViewController : UIViewController

@property (nonatomic ,assign) CurrentViewKind viewKind;
@property (nonatomic ,assign) ViewSearchState serchstate;

@property (nonatomic ,strong) NSMutableArray *moreShoppingArray;


@property (weak, nonatomic) IBOutlet UITableView *moreTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *moreCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

- (IBAction)searchTheCommodityAndView;

@end
