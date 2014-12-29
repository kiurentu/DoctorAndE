//
//  StoreCell.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-21.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commodityImage;
@property (weak, nonatomic) IBOutlet UILabel *commodityLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
