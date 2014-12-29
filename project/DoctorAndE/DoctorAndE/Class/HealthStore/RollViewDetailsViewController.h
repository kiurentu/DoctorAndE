//
//  RollViewDetailsViewController.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-23.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollViewDetailsViewController : UIViewController<UIWebViewDelegate>{
    BOOL _isLoadingFinished;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic ,strong) NSDictionary *detailDic;
@end
