//
//  FirstTimeLoadViewController.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 29/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTimeLoadViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *NameTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *DateOfBirthPicker;

@property (weak, nonatomic) IBOutlet UITextField *HeightTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *HeightOptions;

@property (weak, nonatomic) IBOutlet UITextField *WeightTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *WeightOptions;

- (IBAction)SaveButtonPressed:(id)sender;

@end
