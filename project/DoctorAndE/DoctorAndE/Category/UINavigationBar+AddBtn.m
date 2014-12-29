//
//  UINavigationBar+AddBtn.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-27.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "UINavigationBar+AddBtn.h"

@implementation UINavigationItem (addItem)
- (void)addRightBtn:(UIBarButtonItem *)btn
{
    NSArray *btns = self.rightBarButtonItems;
    if(btns && btns.count) {
        NSMutableArray *newBtns = [[NSMutableArray alloc] initWithArray:btns];
        [newBtns addObject:btn];
        self.rightBarButtonItems = newBtns;
    } else {
        self.rightBarButtonItem = btn;
    }
}

- (void)addRightBtnArray:(NSArray *)btnArr;
{
    NSArray *btns = self.rightBarButtonItems;
    if(btns && btns.count) {
        NSMutableArray *newBtns = [[NSMutableArray alloc] initWithArray:btns];
        
        for(int i=0;i < [btnArr count];i++){
            if([btnArr[i] isKindOfClass:[UIBarButtonItem class]] ){
            [newBtns addObject:btnArr[i]];
            }

        }
            self.rightBarButtonItems = newBtns;
    } else {
        self.rightBarButtonItem = [btnArr firstObject];
    }
}
@end