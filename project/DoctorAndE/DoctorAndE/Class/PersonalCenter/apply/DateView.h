//
//  DateView.h
//  Medical
//
//  Created by iOS09 on 14-11-11.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MonthPickerDelegate <NSObject>

- (void)selectedDate:(NSString *)date;

@end

@interface DateView : UIView

@property (nonatomic, weak) id <MonthPickerDelegate> delegate;



@property (weak, nonatomic) IBOutlet UILabel *chooseDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction)hideDateView:(id)sender;
- (id)initWithFrame:(CGRect)frame withDelegate:(id)delegate;

+ (DateView *)instanceDateView;


@end
