//
//  RollViewDetailsViewController.m
//  DoctorAndE
//
//  Created by SmartGit on 14-12-23.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "RollViewDetailsViewController.h"

@interface RollViewDetailsViewController ()

@end

@implementation RollViewDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //NSLog(@"%@",self.detailDic);
    
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"医加e" withViewController:self];
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSString *str = [self.detailDic objectForKey:@"advertUrl"];
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
       dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView loadRequest:request];
            [self.webView.scrollView setZoomScale:1.5];
       });
    });
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
