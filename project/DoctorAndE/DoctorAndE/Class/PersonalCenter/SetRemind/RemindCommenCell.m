//
//  RemindCommenCell.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#define KEY_SYSTEM_SOUND (@"__systemSound__") //系统消息是否要声音提醒
#define KEY_BELL_SOUND (@"__bellSound__") //消息是否要声音提醒
#define KEY_SHOCK (@"__shock__") //通知时震动提醒

#import "RemindCommenCell.h"
#import "RemindCommen.h"

@implementation RemindCommenCell

-(void)awakeFromNib
{
    self.backgroundColor = RGBCOLOR(229, 229, 229);
    
}

+ (NSString *)ID
{
    return @"remindCommenCell";
}

+(id)remindCommenCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"RemindCommenCell" owner:nil options:nil][0];
}

+(CGFloat)remindCommenCellHeight
{
    return 225;
}

- (IBAction)systemSound:(UIButton *)sender {
    sender.selected =!sender.selected;
    _remindCommen.isSystemSound = sender.selected;
}

- (IBAction)bellSound:(UIButton *)sender {
    sender.selected =!sender.selected;
    _remindCommen.isBellSound = sender.selected;
}

- (IBAction)shock:(UIButton *)sender {
    sender.selected =!sender.selected;
    _remindCommen.isShock = sender.selected;
}

-(void)setRemindCommen:(RemindCommen *)remindCommen
{
    _remindCommen = remindCommen;
    
    _systemSoundBtn.selected = remindCommen.isSystemSound;
    _bellSoundBtn.selected = remindCommen.isBellSound;
    _shockBtn.selected = remindCommen.isShock;

}


@end
