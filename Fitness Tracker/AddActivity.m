//
//  AddActivity.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddActivity.h"
#import "DataMethods.h"

@interface AddActivity ()

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

-(BOOL)prefersStatusBarHidden {                 //A method used to hide the status bar
    return YES;
}


#pragma Activity PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
    ActivityInfo *BurnRate = [activities objectAtIndex:row];
    SelectedCalorieBurnRate = BurnRate.CalorieRate;         //When the picker view is changed the selected calories rate is changed to what has been chosen
    
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
    return activities.count;                //Number of rows is the number of items within the datamodel
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
    
    //This makes it so that the Date picker view will only allow values between a range of dates. For this case i allowed upto 5 days before incase you forgot to add any previous data in.
    
    NSDateComponents *minusfivedays = [[NSDateComponents alloc] init];
    minusfivedays.day = -5;
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDate *fivedaysago = [Calendar dateByAddingComponents: minusfivedays toDate:CurrentDate options:0];
    
    [self.DatePickerView setMaximumDate: CurrentDate];
    [self.DatePickerView setMinimumDate: fivedaysago];
    
    //Reference used for this
    //https://stackoverflow.com/questions/5611632/get-current-date-from-nsdate-date-but-set-the-time-to-1000-am
    
}


#pragma mark Method for calculating how many calories were burnt

//A method called to calculate the amount of calories burnt through the activity
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
    
    //if cancel button is pressed the add activity view will disappear and return to the bar chart
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
    
    //A function to make sure that the date it saves is only the date and not the time specifically. If it does this there will be an issue when doing comparisons.
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:ChosenDate];
    components.hour = 00;
    ChosenDate = [cal dateFromComponents:components];
    
    CaloriesBurnt = [self CalculateCaloriesBurnt];
    
    if (self.TimeWorkedOut > 2.5) {
        //INVALID CODE
        
        //If the user has said they worked out for more than 2 and a half hours it will produce an error as this is deemed unreasonale
        
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"Entry too large"
                                                                message:@"The data that has been entered is considered too large."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [AlertController addAction:OkButton];
        [self presentViewController:AlertController animated:YES completion:nil];
        
        } else {
        //Sucessful save
        
        //if the data is saved succesfully the data is saved into the activity entity within core data
        [DataMethods ACTIVITYAddToDatabase:&(CaloriesBurnt) :ChosenDate];
        
        //Once saved the view will disappear showing the bar chart.
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
