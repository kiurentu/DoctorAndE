//
//  MsmRemindCell.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SetRemind;
@class MsmRemindCell;

@protocol PassCellDelegate<NSObject>

-(void)passCell:(MsmRemindCell *)cell;

@end


@interface MsmRemindCell : UITableViewCell

+ (NSString *)ID;

+ (id)msmRemindCell;

+(CGFloat)msmRemindCellHeight;

@property (weak, nonatomic) IBOutlet UIButton *msmRemindBtn;
@property (weak, nonatomic) IBOutlet UILabel *xmLabel;

@property (strong,nonatomic) SetRemind *setRemid;


@property (weak,nonatomic) id<PassCellDelegate>delegate;


@end
