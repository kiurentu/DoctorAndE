//
//  SerAddressViewController.h
//  医+e
//
//  Created by kang on 14-11-4.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetAddressViewDelegate <NSObject>
@required
- (void)settingIsChange;
@end

/**
 *  设置服务器地址
 */
@interface SetAddressViewController : UIViewController
@property (weak, nonatomic) id<SetAddressViewDelegate> delegate;
@end
