//
//  AddActivity.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddActivity.h"
#import "UserActivityData+CoreDataClass.h"

@interface AddActivity ()
{
    NSArray *activities;
    NSDate *CurrentDate;
    NSDate *ChosenDate;
    NSInteger SelectedCalorieBurnRate;
    CGFloat CaloriesBurnt;
}

@end

@implementation AddActivity

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ActivityPickerView.delegate = self;
    self.ActivityPickerView.dataSource = self;

    self.DataModel = [[ActivityDataModel alloc] init];
    
    activities = self.DataModel.ActivityList;
    
    
    //A series of methods to create the Date format ad also set the Current Date into an NSDate variable
    CurrentDate = [NSDate date];
    NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    NSDateFormatter *DateFormat = [[NSDateFormatter alloc] init];
    [DateFormat setLocale:Locale];
    [DateFormat setDateFormat:@"E,dd,MM,yyyy"];
    
    [self DatePickerViewInit];                  //Sets maximum and minimum values that the date picker view can operate within.
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma Activity PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
    ActivityInfo *BurnRate = [activities objectAtIndex:row];
    SelectedCalorieBurnRate = BurnRate.CalorieRate;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    ActivityInfo *Activity = [activities objectAtIndex:row];
    NSString *ActivityTitle = [NSString stringWithFormat:@"%@", Activity.Activity];
    
    return ActivityTitle;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;           // Set the number of columns to 1
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return activities.count;
    
}


#pragma Removing the background when return is pressed
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet].location != NSNotFound) {
        
        return NO;
        
    }
    
    return YES;
    
}

-(void)DatePickerViewInit {
    
    NSDateComponents *minusfivedays = [[NSDateComponents alloc] init];
    minusfivedays.day = -5;
    
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    
    NSDate *fivedaysago = [Calendar dateByAddingComponents: minusfivedays toDate:CurrentDate options:0];
    
    [self.DatePickerView setMaximumDate: CurrentDate];
    [self.DatePickerView setMinimumDate: fivedaysago];
    
}


#pragma mark Method for calculating how many calories were burnt
-(CGFloat)CalculateCaloriesBurnt {
    
    NSString *MinutesString = [NSString stringWithFormat:@"%@", self.MinuteTextField.text];
    NSString *HourString = [NSString stringWithFormat:@"%@", self.HourTextField.text];
    
    float MinutesWorkedOut = [MinutesString intValue];
    float HoursWorkedOut = [HourString intValue];
    float z = 60;
    self.TimeWorkedOut = (HoursWorkedOut+(MinutesWorkedOut/z));
    
    return (SelectedCalorieBurnRate * self.TimeWorkedOut);
}


#pragma Actions caused by buttons
- (IBAction)SaveButtonPressed:(id)sender {
    [self SaveData];
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)BackgroundPressed:(id)sender {
    
    if([self.HourTextField isFirstResponder]) {
        [self.HourTextField resignFirstResponder];
    }
    
    if ([self.MinuteTextField isFirstResponder]) {
        [self.MinuteTextField resignFirstResponder];
    }
    
}


#pragma Save data function
-(void)SaveData {
    
    
    ChosenDate = self.DatePickerView.date;
    
    //A function to make sure that the date it saves only saves the date and not the time
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:ChosenDate];
    components.hour = 00;
    ChosenDate = [cal dateFromComponents:components];
    
    CaloriesBurnt = [self CalculateCaloriesBurnt];
    
    if (self.TimeWorkedOut > 150) {
        //INVALID CODE
        
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"Entry too large"
                                                                message:@"The data that has been entered is considered too large."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [AlertController addAction:OkButton];
        [self presentViewController:AlertController animated:YES completion:nil];
        
    } else {
        
        //Sucessful save
        NSLog(@"Selected Date: %@", ChosenDate);
        NSLog(@"Calories Burnt: %f", CaloriesBurnt);
        
        [self AddToDatabase];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}


-(void)AddToDatabase {

    NSDictionary *UserActivityInfo = @{@"calories":[NSNumber numberWithFloat:CaloriesBurnt],
                                           @"date":ChosenDate};
    
    [UserActivityData UpdateUserActivity:UserActivityInfo];
    //NSLog(@"Core Data updated with %@",[UserActivityData UpdateUserActivity:UserActivityInfo].description);
    
}

@end
