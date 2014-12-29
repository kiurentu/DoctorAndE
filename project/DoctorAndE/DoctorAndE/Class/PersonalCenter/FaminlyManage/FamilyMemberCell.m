//
//  FamilyMemberCell.m
//  DoctorAndE
//
//  Created by UI08 on 14-12-2.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

//tableView边框的宽度
#define KTableBorderWidth 5
//tableView第一次cell的间距
#define kTableTopBorderWidth 5
//tableView每个celll的间距
#define kTableViewCellMargin 5


#import "FamilyMemberCell.h"
#import "CircleEdge.h"
#import "FamilyModel.h"

@interface FamilyMemberCell ()
{
    
}
@end

@implementation FamilyMemberCell

+ (NSString *)ID
{
    return @"familyCell";
}

+ (id)familyMemberCell {
	return [[NSBundle mainBundle] loadNibNamed:@"FamilyMemberCell" owner:nil options:nil][0];
}

- (void)setFrame:(CGRect)frame {
	//更改X,Y
	frame.origin.x = KTableBorderWidth;
	frame.size.width -= KTableBorderWidth * 2;
    
	//更改顶部间距，每个cell之间的距离
	frame.origin.y += kTableTopBorderWidth;
	frame.size.height -= kTableViewCellMargin;
    
	[super setFrame:frame];
    
	[CircleEdge changView:self];
}
- (void)setIsEdit:(BOOL)isEdit {
	_isEdit = isEdit;
    
	if (isEdit) {
		_selectImageView.hidden = NO;
	}
	else {
		_selectImageView.hidden = YES;
	}
    
}
- (void)setIsSelected:(BOOL)isSelected {
	_isSelected = isSelected;
	_selectImageView.image = [UIImage imageNamed:isSelected ? @"searchbar_popup_box_circle_pressed.png":@"searchbar_popup_box_circle_normal.png"];
}
-(void)setFamilyModel:(FamilyModel *)familyModel
{
    if (_isEdit) {
		_selectImageView.image = [UIImage imageNamed:familyModel.isSelected ? @"searchbar_popup_box_circle_pressed.png":@"searchbar_popup_box_circle_normal.png"];
	}
    _defaultBtn.selected = familyModel.isDefaultMember;
    _defaultLabel.hidden = !familyModel.isDefaultMember;
    _familyModel = familyModel;
    _trueNameLabel.text = familyModel.xm;
  
}
- (IBAction)defaultClick:(id)sender {

    if (_delegate && [_delegate respondsToSelector:@selector(clickFamilyMemberDefaultWithFailyCell:)]) {
        [_delegate clickFamilyMemberDefaultWithFailyCell:self];
    }
}

@end
