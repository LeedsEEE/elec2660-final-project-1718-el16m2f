//
//  AddWeight.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 23/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddWeight : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *WeightPickerView;

- (IBAction)SaveButtonPressed:(id)sender;

- (IBAction)CancelButtonPressed:(id)sender;

@end
