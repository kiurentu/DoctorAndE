//
//  DeleteAddressView.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-8.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeleteAddressViewDelegate<NSObject>

-(void)deletAddress:(id)anyObj;

@end


@interface DeleteAddressView : UIView

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property(nonatomic,weak)id<DeleteAddressViewDelegate>delegate;//使用代理传值
@property(nonatomic,weak)id obj;
+ (DeleteAddressView*)instance;

- (IBAction)cancleClick:(id)sender;
- (IBAction)sureClick:(id)sender;

@end
