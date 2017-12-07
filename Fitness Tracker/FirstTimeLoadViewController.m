//
//  FirstTimeLoadViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 29/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "FirstTimeLoadViewController.h"
#import "UserProfile+CoreDataClass.h"
#import "DataMethods.h"

@interface FirstTimeLoadViewController ()

@end

@implementation FirstTimeLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CurrentDate = [NSDate date];            //Sets the Current date value to the current date
    [self DateOfBirthPickerViewInit];
    
}


-(void)DateOfBirthPickerViewInit {
    
    //By creating 2 date componenets the date picker can have a max and min value, which means you have to be older than a certain age and also younger then a certain time.
    NSDateComponents *MinusEightyYears = [[NSDateComponents alloc] init];
    MinusEightyYears.year = -80;
    NSDateComponents *MinusTwelveYears = [[NSDateComponents alloc] init];
    MinusTwelveYears.year = -12;
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDate *MaxDateOfBirth = [Calendar dateByAddingComponents: MinusEightyYears toDate:CurrentDate options:0];
    NSDate *MinDateOfBirth = [Calendar dateByAddingComponents: MinusTwelveYears toDate:CurrentDate options:0];
    
    [self.DateOfBirthPicker setMaximumDate: MinDateOfBirth];
    [self.DateOfBirthPicker setMinimumDate: MaxDateOfBirth];
    
}

#pragma mark Measurement type toggling
//If the height switch is toggled the value of height type will change so that when calculating it can convert if it is needed.
- (IBAction)HeightToggleSwitch:(id)sender {
    
    if([sender isOn]){
        self.HeightType = 1;
        self.HeightToggleLabel.text = [NSString stringWithFormat:@"Feet"];
    }else{
        self.HeightType = 0;
        self.HeightToggleLabel.text = [NSString stringWithFormat:@"Cm"];
    }
}

//If the weight switch is toggled the value of weight type will change so that when calculating it can convert if it is needed.
- (IBAction)WeightToggleSwitch:(id)sender {

    if([sender isOn]){
        self.WeightType = 1;
        self.WeightToggleLabel.text = [NSString stringWithFormat:@"Lbs"];
    }else{
        self.WeightType = 0;
        self.WeightToggleLabel.text = [NSString stringWithFormat:@"Kgs"];
    }
}

- (IBAction)SaveButtonPressed:(id)sender {
    
    Name = self.NameTextField.text;
    DoB = self.DateOfBirthPicker.date;
    
    //Creating a the height number from a string
    NSString *HeightString = [NSString stringWithFormat:@"%@", self.HeightTextField.text];
    NSNumber *HeightinCM = [NSNumber numberWithFloat: [HeightString floatValue]];
    
    //Creating a the weight number from a string
    NSString *WeightString = [NSString stringWithFormat:@"%@", self.WeightTextField.text];
    NSNumber *WeightinKG = [NSNumber numberWithFloat: [WeightString floatValue]];
    
    if (self.HeightType == 0){        //If true the height will not be converted. If false the height will be converted into Centimetres from Feet
        self.Height = HeightinCM;
    } else {
        self.Height = [NSNumber numberWithDouble:([HeightinCM doubleValue]*CentimetresToFeet)];
    }
    if (self.WeightType == 0){              //If true the weight will not be converted. If false the weight will be converted into Kilograms from Pounds
        self.Weight = WeightinKG;
    } else {
        self.Weight = [NSNumber numberWithDouble:([WeightinKG doubleValue]*KilogramToPounds)];
    }
    
    //Converts the two number entrys into a integer which is used for the if statement
    int EnteredWeight = [self.Weight floatValue];
    int EnteredHeight = [self.Height floatValue];
    
    //A condition created to make sure that the data they enter meets certain criteria and that data has been inputted
    if (EnteredWeight < 50 || EnteredWeight > 210 || EnteredHeight < 135 || EnteredHeight > 250 || [Name length] == 0){
        
        //If it doesn't meet the boundaries of the if statement it shows a UIAlert
        
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"Entry error"
                                                                                 message:@"A data entry is either missing or considered too small."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [AlertController addAction:OkButton];
        [self presentViewController:AlertController animated:YES completion:nil];
        
    } else {
        
        //If the entries are allowed they are saved to the database and a user default saved to say that the profile has been made.
        [self AddToDatabase];
    
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UserFirstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //User default - https://stackoverflow.com/questions/29213374/how-can-you-create-an-instructional-screen-that-only-appears-the-first-time-in
    
        [self LeaveView];
        
    }
}



- (void)AddToDatabase {
    //Creates a dictionary to which can then be passed into the UpdateUserProfile method
    NSDictionary *UserInfo = @{@"Name": Name,
                               @"DoB": DoB,
                               @"Height": self.Height,
                               @"Weight": self.Weight};
    
    [UserProfile UpdateUserProfile:UserInfo];
    //References used to save data
    //HuxTex – Core Data I part 32: https://www.youtube.com/watch?v=EGO9XBFrZE0&t=1089s
    //HuxTex – Core Data II part 33: https://www.youtube.com/watch?v=p_INW9noMDI
    
    
    NSCalendar *NewCalendar = [NSCalendar currentCalendar];
    CurrentDate = [NSDate date];
    NSDateComponents *components = [NewCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
    components.hour = 00;
    components.year = 2016;
    NSDate *PastDate = [NewCalendar dateFromComponents:components];
    //References used to create a data from a date
    //https://stackoverflow.com/questions/5611632/get-current-date-from-nsdate-date-but-set-the-time-to-1000-am
    
    CGFloat WeightToCoreData = [self.Weight floatValue];
    [DataMethods WEIGHTAddToDatabase:&WeightToCoreData :PastDate];    //Saving the weight inputted into the weight core data
    
}


#pragma mark Removing the keyboard via the return key and a background press
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

    //When the background is pressed the text file will go away
- (IBAction)BackgroundPressed:(id)sender {
    
    if ([self.NameTextField isFirstResponder]){
        [self.NameTextField resignFirstResponder];
    }
    
    if ([self.HeightTextField isFirstResponder]){
        [self.HeightTextField resignFirstResponder];
    }
    
    if([self.WeightTextField isFirstResponder]){
        [self.WeightTextField resignFirstResponder];
    }
    
}

-(void) LeaveView {
    
    //Method used to move segue programically to return to the first tab screen
    [self performSegueWithIdentifier:@"ContinueApp" sender:nil];
    
}


@end
