//
//  MsmRemindCell.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "MsmRemindCell.h"
#import "SetRemind.h"

@implementation MsmRemindCell

+ (NSString *)ID
{
    return @"msmRemindCel";
}

+ (id)msmRemindCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"MsmRemindCell" owner:nil options:nil][0];
}

+(CGFloat)msmRemindCellHeight
{
    return 44;
}
- (IBAction)msmRemindClick:(UIButton *)sender {
    
     sender.selected =!sender.selected;
    _setRemid.isSelect = sender.selected;
    _setRemid.message = sender.selected?@"1":@"0";
    
    if (_delegate && [_delegate respondsToSelector:@selector(passCell:)]) {
        
        [_delegate passCell:self];
    }
}

-(void)setSetRemid:(SetRemind *)setRemid
{
    _setRemid = setRemid;
    
    _xmLabel.text = setRemid.xm;
    
    if ([setRemid.message intValue]) {
        _msmRemindBtn.selected = YES;
        
    }else{
        _msmRemindBtn.selected = NO;
    }
    
}



@end
