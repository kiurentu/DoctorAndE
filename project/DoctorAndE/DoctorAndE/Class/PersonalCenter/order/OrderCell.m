//
//  OrderCell.m
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (IBAction)orderDelete:(id)sender {
}

@end
