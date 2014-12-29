//
//  StoreViewDetailsViewController.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-25.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

typedef NS_ENUM(NSInteger, ViewKind){
    detailedIntroduction = 1,
    evaluateIntroduction
};//评价视图或详细视图

#import <UIKit/UIKit.h>

@interface StoreViewDetailsViewController : UIViewController

@property (nonatomic ,assign) ViewKind viewKind;
@property (nonatomic ,strong) NSString *commodityId;

@property (weak, nonatomic) IBOutlet UILabel *commodityName;
@property (weak, nonatomic) IBOutlet UILabel *commdityDetail;

@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *originaPrice;

@property (weak, nonatomic) IBOutlet UILabel *commdityCode;
@property (weak, nonatomic) IBOutlet UILabel *stockQuantity;
@property (weak, nonatomic) IBOutlet UILabel *salesVolume;
@property (weak, nonatomic) IBOutlet UILabel *express;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *tabControlView;

@property (weak, nonatomic) IBOutlet UIButton *introduceButton;
@property (weak, nonatomic) IBOutlet UIImageView *slideLine;

@property (weak, nonatomic) IBOutlet UIView *evaluateView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonArray;

- (IBAction)clicksliderButton:(UIButton *)sender;

-(IBAction)clickEvaluateButton:(UIButton *)sender;
@end
