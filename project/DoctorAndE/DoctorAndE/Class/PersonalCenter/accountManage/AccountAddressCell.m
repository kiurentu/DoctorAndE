//
//  AccountAddressCell.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//
//tableView边框的宽度
#define KTableBorderWidth 5
//tableView第一次cell的间距
#define kTableTopBorderWidth 5
//tableView每个celll的间距
#define kTableViewCellMargin 5

#import "AccountAddressCell.h"
#import "CircleEdge.h"


@interface AccountAddressCell ()<UIGestureRecognizerDelegate>

@end

@implementation AccountAddressCell

-(void)awakeFromNib{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableviewCellLongPressed:)];
    longPress.delegate = self;
    longPress.minimumPressDuration = 0.5f;
    [self addGestureRecognizer:longPress];
    
}
//长按事件的实现方法
- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateBegan) {
    }
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateChanged) {
 
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        if (_delegate && [_delegate respondsToSelector:@selector(clickLong:)]) {
            [_delegate clickLong:self];
        }
    }
    
}


+ (id)accountAddressCell {
	return [[NSBundle mainBundle] loadNibNamed:@"AccountAddressCell" owner:nil options:nil][0];
}

+ (NSString *)ID {
	return @"collectCell";
}

+ (CGFloat)cellHeight
{
    return 120;
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


-(void)setAddressModel:(AddressModel *)addressModel
{
    _addressModel = addressModel;
    _trueNameLabel.text = addressModel.userName;
    _phoneLabel.text = addressModel.phone;
    _addressLabel.text = addressModel.address;
    _postalCodeLabel.text = addressModel.postalCode;
    _receiverInfoId = addressModel.receiverInfoId;
    
}

@end
