//
//  AddWeight.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 23/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddWeight.h"
#import "DataMethods.h"

@interface AddWeight ()
@end

@implementation AddWeight

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark WeightPickerView delegate
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

#pragma mark WeightPickerView datasource
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


#pragma mark Navigation button methods
- (IBAction)SaveButtonPressed:(id)sender {
    
    CurrentDate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
    components.hour = 00;
    
    CurrentDate = [cal dateFromComponents:components];
    
    if(Weight<40 || Weight>170){                        //If the weight is out of certain boundaries an error shows
        
        [self ExceededLimitsAlert];
        
    } else if (CurrentDate == [DataMethods DateOfMostRecentWeightSave]){
        
        [self SavingOnTheSameDayAlert];                 //If the user is saving onto an allready saved date it shows an error
        
    } else {
        
        [DataMethods WEIGHTAddToDatabase:&(Weight) :CurrentDate];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark methods for creating alerts to show
-(void) ExceededLimitsAlert {
    
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"Entry out of range"
                                                                             message:@"The data that has been entered is considered either too large or too small."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [AlertController addAction:OkButton];
    [self presentViewController:AlertController animated:YES completion:nil];

}

-(void) SavingOnTheSameDayAlert{
    
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"Entry allready made"
                                                                             message:@"You have allready made a data entry for today"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [AlertController addAction:OkButton];
    [self presentViewController:AlertController animated:YES completion:nil];
    
}

@end
