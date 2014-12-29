//
//  HearView.m
//  PoGame
//
//  Created by CHEN_新杰 on 14-10-15.
//  Copyright (c) 2014年 iOS07. All rights reserved.
//

#define knavigationHeght 44
#define kstatusBarHeight 20

#import "HearView.h"

@implementation HearView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}

-(id)initWithTitle:(NSString *)titleStr WithLeftText:(NSString *)leftText WithLeftImage:(NSString *)leftImage WithRightText:(NSString *)rightText WithRightImage:(NSString *)rightImage WithViewControl:(id<HearViewDelegate>)delegate{
    
    float Y = 0;
    if (IOS7) {
        Y = 10;
    }
    self = [super initWithFrame:CGRectMake(0, Y, 320, knavigationHeght)];
    if (self) {
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.frame];
        imageView.image=[UIImage imageNamed:@"navigationBack"];
        [self addSubview:imageView];
        
        if(titleStr){
            //标题
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 9+Y, 255, 21)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = titleStr;
            titleLabel.textColor=[UIColor whiteColor];
            titleLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
            [self addSubview:titleLabel];
        }
        
        if(leftImage){
            //左边按钮
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0, 0, 50, 44);
            [backButton addTarget:delegate action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:backButton];
            //左边按钮图标
            UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 11+Y, 20, 20)];
            backImageView.image = [UIImage imageNamed:leftImage];
            [self addSubview:backImageView];
            
            if (leftText) {
                UILabel *label = [[UILabel alloc]init];
                label.backgroundColor = [UIColor clearColor];
                label.textColor= [UIColor whiteColor];
                label.text = leftText;
                CGSize sizeLabel = [leftText sizeWithFont:[UIFont systemFontOfSize:17]
                                       constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
                                           lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat labelX = 30;
                CGFloat labelY = 11+Y;
                label.frame = (CGRect){{labelX,labelY},sizeLabel};
                [self addSubview:label];
            }
        }
        
        
        if (rightImage) {
            //右边按钮
            UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
            searchButton.frame = CGRectMake(270, 0, 50, 42);
            [searchButton addTarget:delegate action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:searchButton];
            //右边按钮图标
            UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(291, 11+Y-5, 20, 20)];
            searchImageView.image = [UIImage imageNamed:rightImage];
            [self addSubview:searchImageView];
        }
    }
    
    return self;
}


@end
