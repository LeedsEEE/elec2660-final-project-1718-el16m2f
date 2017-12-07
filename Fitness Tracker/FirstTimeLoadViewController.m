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
{
    //NSNumber *KgstoLbs;
    //NSNumber *MtoFt;
    
    NSDate *CurrentDate;
    NSString *Name;
    NSDate *DoB;
    
    //BOOL PerformProfileScreen;
}

@property NSNumber *Height;
@property NSNumber *Weight;

@end

@implementation FirstTimeLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CurrentDate = [NSDate date];
    
    [self DateOfBirthPickerViewInit];
    
}


-(void)DateOfBirthPickerViewInit {
    
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
- (IBAction)HeightToggleSwitch:(id)sender {
    
    if([sender isOn]){
        
        self.HeightType = 1;
        self.HeightToggleLabel.text = [NSString stringWithFormat:@"Feet"];
        
    }else{
        
        self.HeightType = 0;
        self.HeightToggleLabel.text = [NSString stringWithFormat:@"Cm"];
        
    }
  
    
}

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
    NSNumber *HeightinM = [NSNumber numberWithFloat: [HeightString floatValue]];
    
    //Creating a the weight number from a string
    NSString *WeightString = [NSString stringWithFormat:@"%@", self.WeightTextField.text];
    NSNumber *WeightinKG = [NSNumber numberWithFloat: [WeightString floatValue]];
    
    if (self.HeightType == 0){        //If Height type is true set to metres
        
        self.Height = HeightinM;

    } else {
        
        self.Height = [NSNumber numberWithDouble:([HeightinM doubleValue]*CentimetresToFeet)]; //////////IMPLEMENT THE CONVERSION INTO ft
    }
    
    if (self.WeightType == 0){
        
        self.Weight = WeightinKG;
        
    } else {
        
        self.Weight = [NSNumber numberWithDouble:([WeightinKG doubleValue]*KilogramToPounds)];; //////////IMPLEMENT THE CONVERSION INTO Lbs
        
    }
    
    if (self.Weight == 0 || self.Height == 0 || [Name length] == 0){
        
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"Entry missing"
                                                                                 message:@"A data entry is missing."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [AlertController addAction:OkButton];
        [self presentViewController:AlertController animated:YES completion:nil];
        
    } else {
        
        [self AddToDatabase];
    
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UserFirstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        [self LeaveView];
        
    }
}



- (void)AddToDatabase {
    
    NSDictionary *UserInfo = @{@"Name": Name,
                               @"DoB": DoB,
                               @"Height": self.Height,
                               @"Weight": self.Weight};
    
    [UserProfile UpdateUserProfile:UserInfo];
    
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.hour = 00;                                               //Setting the time of the current day to midnight
    CurrentDate = [Calendar dateFromComponents:components];
    components.day = -20;
    NSDate *DateToSave = [Calendar dateByAddingComponents:components toDate:CurrentDate options:0];
                                                                        //Creating a date 20 days prior to making the account
    CGFloat WeightToCoreData = [self.Weight floatValue];
    [DataMethods WEIGHTAddToDatabase:&WeightToCoreData :DateToSave];    //Saving the weight inputted into the weight core data
    
}


#pragma mark Removing the keyboard via the return key and a background press
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;     ///////THIS NEED IMPLEMENTING
    
}

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
    
    [self performSegueWithIdentifier:@"ContinueApp" sender:nil];
    
}


@end
