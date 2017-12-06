//
//  AddWeight.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 23/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddWeight.h"

@interface AddWeight ()

{
    float hundreds;
    float tens;
    float singular;
    float decimal;
}

@end

@implementation AddWeight

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma WeightPickerView setip
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

-(void)pickerView:(UIPickerView *)pickerView
        didSelectRow:(NSInteger)row
        inComponent:(NSInteger)component {

    if (component == 0){
        hundreds = (row*100);
    } else if(component == 1){
        tens = (row*10);
    } else if(component == 2){
        singular = row;
    } else if(component == 4){
        float rowvalue = row;
        decimal = (rowvalue/10);
    } else if(component == 5){
        if (row == 0){
            MeasurementType = FALSE;
        }else{
            MeasurementType = TRUE;
        }
    }
    
    if(MeasurementType == FALSE){
        Weight = (hundreds+tens+singular+decimal);
    } else {
        Weight = ((hundreds+tens+singular+(decimal/10))/KilogramsToPounds);
    }
}

- (IBAction)SaveButtonPressed:(id)sender {
    
    NSLog(@"Recorded weight = %.1f",Weight);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
