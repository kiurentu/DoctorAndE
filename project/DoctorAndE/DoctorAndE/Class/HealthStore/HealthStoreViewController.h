//
//  HealthStoreViewController.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFScrollView;
/**
 *  健康商城
 */
@interface HealthStoreViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (nonatomic ,weak) IBOutlet UICollectionView *shopView;

@property (nonatomic ,strong) FFScrollView *ffScrollView;
@end
