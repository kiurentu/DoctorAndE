//
//  DeleteFamilyView.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeleteFamilyViewDelegate<NSObject>

-(void)deletFamilyMember;

@end

@interface DeleteFamilyView : UIView

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property(nonatomic,weak)id<DeleteFamilyViewDelegate>delegate;//使用代理传值
+ (DeleteFamilyView*)instance;

- (IBAction)cancleClick:(id)sender;
- (IBAction)sureClick:(id)sender;

@end
