//
//  AddWeight.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 23/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddWeight.h"

@interface AddWeight ()

@end

@implementation AddWeight

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma WeightPickerView setip

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 6;                                                                               //Setting the number of columns in the picker view to 5. 2 numbers, a decimal place, a number and a measurement choice.
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rows;
    
    
    if(component == 0){
        rows = 2;
    }else if(component == 3) {
        rows = 1;
    }else if(component == 5){
        rows = 2;
    }else{
        rows = 10;
    }
    
    return rows;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    NSString *Title;
        
    if(component == 3){
        
        Title = [NSString stringWithFormat:@"."];
        
    }else if(component == 5){
        
        if (row == 0){
            Title = [NSString stringWithFormat:@"Kg"];
        }else if(row == 1){
            Title = [NSString stringWithFormat:@"lb"];
        }
        
    }else{
        
        Title = [NSString stringWithFormat:@"%li",row];
        
    }
    
    return Title;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (IBAction)SaveButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
