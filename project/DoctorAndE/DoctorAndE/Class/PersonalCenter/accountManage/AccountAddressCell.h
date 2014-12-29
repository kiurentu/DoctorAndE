//
//  AccountAddressCell.h
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//
/**
 *  地址的cell
 */

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@class AccountAddressCell;


@protocol AccountAddressCellDelegate<NSObject>

-(void)clickLong:(AccountAddressCell *)cell;

@end


@interface AccountAddressCell : UITableViewCell

@property(nonatomic,strong)AddressModel *addressModel;
@property (weak, nonatomic) IBOutlet UILabel *trueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *postalCodeLabel;
@property(nonatomic,copy) NSString *receiverInfoId;


@property(nonatomic,weak)id<AccountAddressCellDelegate>delegate;//使用代理传值

+ (id)accountAddressCell;
+ (NSString *)ID;
+ (CGFloat)cellHeight;
@end
