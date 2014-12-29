//
//  MyOrderViewController.m
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "MyOrderViewController.h"
#import "DateView.h"
#import "Order.h"
#import "OrderCell.h"

@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

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
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"我的预约" withViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderCellIdentifier";

    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = RGBCOLOR(240, 240, 240);
    }

    cell.orderType = [NSString stringWithFormat:@"%ld", [indexPath row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (IBAction)chooseDate:(id)sender
{
    NSLog(@"点击");
    DateView *text = [DateView instanceDateView];
    text.frame = CGRectMake(0, 0, text.frame.size.width, text.frame.size.height);
    [self.view addSubview:text];
}

- (IBAction)chooseState:(id)sender {}

@end