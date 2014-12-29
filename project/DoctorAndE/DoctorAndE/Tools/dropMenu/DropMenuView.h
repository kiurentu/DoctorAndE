//
//  DropMenuView.h
//  ManyButton
//
//  Created by UI08 on 14-11-5.
//  Copyright (c) 2014年 CZA. All rights reserved.
//
typedef enum {
    MenuTypeOpen = 0,
    MenuTypeClose
}MenuType;

//typedef void (^MenuBlock)(NSString *str);

#import <UIKit/UIKit.h>

@protocol DropMenuViewDelegate<NSObject>

-(void)clickMenu:(NSString *)str;

@end

@interface DropMenuView : UIView

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)arr withImage:(NSString *)imageName withviewController:(UIViewController *)viewController;

@property(nonatomic,assign) MenuType menuType;

@property(nonatomic,weak)id<DropMenuViewDelegate>delegate;//使用代理传值
@property(nonatomic,copy)void(^menuBlock)(NSString *str);//使用block传值

//@property(nonatomic,copy)MenuBlock menuBlock;


@end
