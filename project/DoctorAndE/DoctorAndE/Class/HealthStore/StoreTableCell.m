//
//  StoreTableCell.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "StoreTableCell.h"

@implementation StoreTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //固定图片
    self.imageView.frame = CGRectMake(5, 5, 100, 100);
    //self.imageView.backgroundColor = [UIColor redColor];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
