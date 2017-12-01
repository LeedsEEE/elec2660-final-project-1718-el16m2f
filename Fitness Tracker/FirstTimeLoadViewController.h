//
//  FirstTimeLoadViewController.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 29/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTimeLoadViewController : UIViewController <UITextFieldDelegate>

@property Boolean *WeightType;      //If NO measured in KG, if YES measured in lbs
@property Boolean *HeightType;      //If No measured in cm, if YES measured in ft

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *DateOfBirthPicker;

@property (weak, nonatomic) IBOutlet UITextField *HeightTextField;

@property (weak, nonatomic) IBOutlet UITextField *WeightTextField;

- (IBAction)HeightToggleSwitch:(id)sender;
- (IBAction)WeightToggleSwitch:(id)sender;


- (IBAction)SaveButtonPressed:(id)sender;

@end
