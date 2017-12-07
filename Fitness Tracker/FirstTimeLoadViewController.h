//
//  FirstTimeLoadViewController.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 29/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTimeLoadViewController : UIViewController <UITextFieldDelegate>

{
    NSDate *CurrentDate;
    NSString *Name;
    NSDate *DoB;
}


@property NSInteger WeightType;      //If NO measured in KG, if YES measured in lbs
@property NSInteger HeightType;      //If No measured in cm, if YES measured in ft

@property NSNumber *Height;
@property NSNumber *Weight;

#define KilogramToPounds 2.20462
#define CentimetresToFeet 0.0328084

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *DateOfBirthPicker;

@property (weak, nonatomic) IBOutlet UITextField *HeightTextField;

@property (weak, nonatomic) IBOutlet UITextField *WeightTextField;

- (IBAction)HeightToggleSwitch:(id)sender;
- (IBAction)WeightToggleSwitch:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *HeightToggleLabel;
@property (weak, nonatomic) IBOutlet UILabel *WeightToggleLabel;

- (IBAction)SaveButtonPressed:(id)sender;
- (IBAction)BackgroundPressed:(id)sender;



@end
