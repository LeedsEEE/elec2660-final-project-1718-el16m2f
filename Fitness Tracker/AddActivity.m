//
//  AddActivity.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddActivity.h"

@interface AddActivity () {
    
    NSArray *activities;
    
}

@end

@implementation AddActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _SaveActivityButton.layer.cornerRadius = 25;
    
    self.ActivityPickerView.delegate = self;
    self.ActivityPickerView.dataSource = self;

    self.DataModel = [[ActivityDataModel alloc] init];
    
    activities = self.DataModel.ActivityList;
    
    
}

#pragma Activity PickerView Delegate

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    ActivityInfo *Activity = [activities objectAtIndex:row];
    NSString *ActivityTitle = [NSString stringWithFormat:@"%@", Activity.Activity];
    
    return ActivityTitle;
    
}


-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;           // Set the number of columns to 1
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return activities.count;
    
}





- (IBAction)SaveButtonPressed:(id)sender {
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
