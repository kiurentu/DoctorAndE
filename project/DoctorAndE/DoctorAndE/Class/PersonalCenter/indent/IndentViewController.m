//
//  IndentViewController.m
//  Medical
//
//  Created by iOS09 on 14-11-14.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "IndentViewController.h"
#import "ComplaintViewController.h"
#import "ConfimationViewController.h"
#import "EvaluateViewController.h"
#import "PackageViewController.h"
#import "RefundViewController.h"


@interface IndentViewController ()

@end

@implementation IndentViewController



- (void)viewDidLoad {
	[super viewDidLoad];

	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
	// Return the number of sections.
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
	// Return the number of rows in the section.
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	// Configure the cell...

	return cell;
}

/*
   // Override to support conditional editing of the table view.
   - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
   {
    // Return NO if you do not want the specified item to be editable.
    return YES;
   }
 */

/*
   // Override to support editing the table view.
   - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
   {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
   }
 */

/*
   // Override to support rearranging the table view.
   - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
   {
   }
 */

/*
   // Override to support conditional rearranging of the table view.
   - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
   {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
   }
 */

/*
   #pragma mark - Table view delegate

   // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
   - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
   {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.

    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
   }

 */

- (IBAction)confirmation:(id)sender {
	ConfimationViewController *confiramationView = [[ConfimationViewController alloc]init];
	[self.navigationController pushViewController:confiramationView animated:YES];
}

- (IBAction)complaints:(id)sender {
	ComplaintViewController *complaintView = [[ComplaintViewController alloc]init];
	[self.navigationController pushViewController:complaintView animated:YES];
}

- (IBAction)package:(id)sender {
	PackageViewController *packegeView = [[PackageViewController alloc]init];
	[self.navigationController pushViewController:packegeView animated:YES];
}

- (IBAction)refund:(id)sender {
	RefundViewController *refundView = [[RefundViewController alloc]init];
	[self.navigationController pushViewController:refundView animated:YES];
}

- (IBAction)evaluate:(id)sender {
	EvaluateViewController *evaluateView = [[EvaluateViewController alloc]init];
	[self.navigationController pushViewController:evaluateView animated:YES];
}

- (IBAction)delete:(id)sender {
	UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:@"是否删除该订单" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];

	[alter show];
}

@end
