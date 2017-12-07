//
//  AddWeight.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 23/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddWeight : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate>
{
    BOOL MeasurementType;           //True in Kg, False in Lbs
    
    //Variables used to create the Weight
    float hundreds;
    float tens;
    float singular;
    float decimal;
    
    //Variables to save into core data
    CGFloat Weight;
    NSDate *CurrentDate;
}

#define KilogramsToPounds 2.20462                   //Definition of a conversion rate

@property (weak, nonatomic) IBOutlet UIPickerView *WeightPickerView;

- (IBAction)SaveButtonPressed:(id)sender;

- (IBAction)CancelButtonPressed:(id)sender;

@end
