//
//  DatePickerView.h
//  Birethday
//
//  Created by UI08 on 14-11-13.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)selectedDate:(NSString *)date;

@end


@interface DatePickerView : UIView

@property (nonatomic, weak) id <DatePickerViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)finish:(id)sender;

- (id)initWithFrame:(CGRect)frame withDelegate:(id)delegate;


@end
