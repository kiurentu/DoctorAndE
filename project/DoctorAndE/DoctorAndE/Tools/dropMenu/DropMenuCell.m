//
//  DropMenuCell.m
//  ManyButton
//
//  Created by UI08 on 14-11-5.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import "DropMenuCell.h"

@interface DropMenuCell ()

@end

@implementation DropMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [RGBCOLOR(181, 181, 181) CGColor];
        //1.添加子控件
        [self addStatusSubviews];
        
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = RGBCOLOR(25, 153, 91);
        self.selectedBackgroundView = image;
    
    }
    return self;
}

+(NSString *)ID
{
    return @"dropMenuCell";
}

-(void)addStatusSubviews
{
    _menuLabel = [[UILabel alloc] init];
    _menuLabel.font = [UIFont systemFontOfSize:17];
    _menuLabel.textColor = [UIColor blackColor];
    _menuLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_menuLabel];
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height += 1;
    [super setFrame:frame];
}


@end
