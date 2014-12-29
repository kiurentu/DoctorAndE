//
//  personCenterCell.m
//  医+e
//
//  Created by kang on 14-10-30.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "PersonCenterCell.h"
#import "PersionCenterCellFrame.h"
#import "PersonCenter.h"
@interface PersonCenterCell ()
{
    NSString *_strName;
}
@end
@implementation PersonCenterCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];


    // 1.3.设置cell的背景view
    UIImageView *bg = [[UIImageView alloc] init];
    self.backgroundView = bg;

    UIImageView *selectedBg = [[UIImageView alloc] init];
    self.selectedBackgroundView = selectedBg;
}

#pragma mark 重写setFrame方法，自己调整cell的frame
- (void)setFrame:(CGRect)frame
{
    // 更改x、宽度
    frame.origin.x = 3;
    frame.size.width -= 3 * 2;
    [super setFrame:frame];
}

- (void)setPersonCenterCellFrame:(PersionCenterCellFrame *)personCenterCellFrame
{
    _personCenterCellFrame = personCenterCellFrame;

    PersonCenter *personCenter = personCenterCellFrame.personCenter;

    _img.frame = personCenterCellFrame.img;
    _strName = personCenter.img;
    _img.image = [UIImage imageNamed:_strName];
    _textNmae.frame = personCenterCellFrame.textNmae;

    _textNmae.text = personCenter.textName;
    _detailtext.frame = personCenterCellFrame.detailtext;
    _detailtext.text = personCenter.detailtext;
}

#pragma mark 重写hightLight

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

- (void)setArray:(NSArray *)array
{
    _array = array;

    // 3.设置背景
    // 3.1.取出背景view
    UIImageView *bg = (UIImageView *)self.backgroundView;
    UIImageView *selectedBg = (UIImageView *)self.selectedBackgroundView;
    int         count = array.count;

    NSString *name = nil;

    if (count == 1) {                           // 只有1个
        name = @"common_card_background.png";
    } else if (_indexPath.row == 0) {           // 顶部
        name = @"common_card_top_background.png";
    } else if (_indexPath.row == count - 1) {   // 底部
        name = @"common_card_bottom_background.png";
    } else {                                    // 中间
        name = @"common_card_middle_background.png";
    }

    // 3.3.设置背景图片
    bg.image = [UIImage stretchImaheWithName:name];
    selectedBg.image = [UIImage stretchImaheWithName:[name fileNameAppend:@"_highlighted."]];
}

@end