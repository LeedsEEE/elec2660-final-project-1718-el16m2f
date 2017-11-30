//
//  AddActivity.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDataModel.h"
//#import "ActivityInfo.h"

@interface AddActivity : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate>

@property (strong, nonatomic) ActivityDataModel *DataModel;

@property (weak, nonatomic) IBOutlet UIPickerView *ActivityPickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *DatePickerView;

@property (weak, nonatomic) IBOutlet UITextField *HourTextField;
@property (weak, nonatomic) IBOutlet UITextField *MinuteTextField;

- (IBAction)SaveButtonPressed:(id)sender;
- (IBAction)CancelButtonPressed:(id)sender;

- (IBAction)BackgroundPressed:(id)sender;

@end
