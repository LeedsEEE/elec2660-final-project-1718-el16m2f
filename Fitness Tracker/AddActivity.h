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

@interface AddActivity : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate>

@property (strong, nonatomic) ActivityDataModel *DataModel;

@property (weak, nonatomic) IBOutlet UIImageView *ActivityIconView;
@property (weak, nonatomic) IBOutlet UIPickerView *ActivityPickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *DatePickerView;

@property (weak, nonatomic) IBOutlet UITextField *HourTextField;
@property (weak, nonatomic) IBOutlet UITextField *MinuteTextField;


@property (weak, nonatomic) IBOutlet UIButton *SaveActivityButton;
- (IBAction)SaveButtonPressed:(id)sender;

@end
