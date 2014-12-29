//
//  UINavigationBar+AddBtn.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-27.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (addItem)
- (void)addRightBtn:(UIBarButtonItem*)btn;

- (void)addRightBtnArray:(NSArray *)btnArr;
@end