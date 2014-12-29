//
//  FamilyMemberCell.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-2.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//


#import <UIKit/UIKit.h>
@class FamilyModel;
@class FamilyMemberCell;

@protocol FamilyMemberCellDelegate<NSObject>

-(void)clickFamilyMemberDefaultWithFailyCell:(FamilyMemberCell *)familyCell;

@end

@interface FamilyMemberCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (nonatomic, assign) BOOL isEdit;//是否编辑
@property (nonatomic, assign) BOOL isSelected;//是否选中
@property (nonatomic, strong) FamilyModel *familyModel;
@property(nonatomic,weak)id<FamilyMemberCellDelegate>delegate;//使用代理传值
@property (weak, nonatomic) IBOutlet UILabel *trueNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

- (IBAction)defaultClick:(id)sender;

+ (NSString *)ID;
+ (id)familyMemberCell;



@end
