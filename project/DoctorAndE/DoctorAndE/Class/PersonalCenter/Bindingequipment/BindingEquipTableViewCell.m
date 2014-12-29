//
//  BindingEquipTableViewCell.m
//  DoctorAndE
//
//  Created by kang on 14-12-2.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "BindingEquipTableViewCell.h"



@implementation BindingEquipTableViewCell

- (void)awakeFromNib
{
    self.equipNameLabel.text = self.equipModel.equipNameStr;
    self.equipNumberLabel.text = self.equipModel.equipNumberStr;
    self.equipTestLabel.text = self.equipModel.equipTestStr;

    _serialNameberSubStr =self.equipModel.serialNumberStr;
    //序列号加密
    _serialNameberSubStr = [NSString stringWithFormat:@"%@**",[_serialNameberSubStr substringToIndex:_serialNameberSubStr.length-2]];
    self.serialNumberLabel.text = _serialNameberSubStr;

}

-(void)setEquipModel:(EquipMode *)equipModel
{
    _equipModel = equipModel;
    self.equipNameLabel.text = equipModel.equipNameStr;
    self.equipNumberLabel.text = equipModel.equipNumberStr;
    //测试项
    NSDictionary *dict = [[NSDictionary alloc]init];
    for (dict in equipModel.equipTestArr) {
        switch ([dict[@"type"] intValue]) {
            case 1:
             equipTestStr = @"血压";
                break;
            case 2:
                equipTestStr = @"血糖";
                break;
            case 3:
                equipTestStr = @"体温";
                break;
            case 4:
                equipTestStr = @"血氧";
                break;
            case 5:
                equipTestStr = @"血脂仪";
                break;
            case 100:
                equipTestStr = @"心电监护仪";
                break;
            default:
                break;
        }
        if (equipModel.equipTestArr.count==1) {
            
        }else{
            equipTestStr = [equipTestStr stringByAppendingString:[NSString stringWithFormat:@"、%@",equipTestStr]];
        }
        
    }
    self.equipTestLabel.text =equipTestStr;
    _serialNameberSubStr =equipModel.serialNumberStr;
    //序列号加密
    _serialNameberSubStr = [NSString stringWithFormat:@"%@**",[_serialNameberSubStr substringToIndex:_serialNameberSubStr.length-2]];
    self.serialNumberLabel.text = _serialNameberSubStr;
}

@end
