//
//  AddActivity.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddActivity.h"

@interface AddActivity ()

@end

@implementation AddActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _SaveActivityButton.layer.cornerRadius = 25;
    
    self.ActivityPickerView.delegate = self;
    self.ActivityPickerView.dataSource = self;
    
    //self.Activity = [[ActivityDataModel alloc]init];
    
    
}

#pragma Activity PickerView Delegate

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    NSString *ActivityTitle = [NSString stringWithFormat:@"%li",row];
    
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
    
    NSArray *list = [[NSArray alloc] init];
    
    list = self.Activity.ActivityList;
    
    NSInteger number = [list count];
    
    return number;
    
}





- (IBAction)SaveButtonPressed:(id)sender {
    
}

@end
