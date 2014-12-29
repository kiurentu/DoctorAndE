//
//  BindingEquipTableViewCell.h
//  DoctorAndE
//
//  Created by kang on 14-12-2.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  绑定设备cell

#import <UIKit/UIKit.h>
#import "EquipMode.h"

@interface BindingEquipTableViewCell : UITableViewCell
{
    NSString *str;
    NSString *equipTestStr;
}

@property (weak, nonatomic) IBOutlet UIButton *unbindBtn;//解绑按钮
@property (weak, nonatomic) IBOutlet UILabel *equipNameLabel;//设备名称
@property (weak, nonatomic) IBOutlet UILabel *equipNumberLabel;//设备型号
@property (weak, nonatomic) IBOutlet UILabel *equipTestLabel;//测试项
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;//序列号

@property (nonatomic,strong) EquipMode *equipModel;
@property (nonatomic,strong)NSString *serialNameberSubStr;
@end
