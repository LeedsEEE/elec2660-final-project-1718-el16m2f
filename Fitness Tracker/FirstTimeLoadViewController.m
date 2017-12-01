//
//  FirstTimeLoadViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 29/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "FirstTimeLoadViewController.h"
#import "UserProfile+CoreDataClass.h"

@interface FirstTimeLoadViewController ()
{
    NSNumber *KgstoLbs;
    NSNumber *MtoFt;
    
    NSDate *CurrentDate;
    NSString *Name;
    NSDate *DoB;
}

@property (nonatomic, weak) NSNumber *Height;
@property (nonatomic, weak) NSNumber *Weight;

@end

@implementation FirstTimeLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//#define KgsToLbs 2.20462
//#define MtoFt 3.28084
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"HasViewedAppBefore"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasviewedappbefore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else {
        
        [self performSegueWithIdentifier:@"DisplayTabs" sender:nil];
        
    }
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (IBAction)SaveButtonPressed:(id)sender {
    
    Name = self.NameTextField.text;
    DoB = self.DateOfBirthPicker.date;
    
    NSString *HeightString = [NSString stringWithFormat:@"%@", self.HeightTextField.text];
    NSString *WeightString = [NSString stringWithFormat:@"%@", self.WeightTextField.text];
    NSNumber *HeightinM = [NSNumber numberWithFloat: [HeightString floatValue]];
    NSNumber *WeightinKG = [NSNumber numberWithFloat: [WeightString floatValue]];
    
    if (self.HeightType == 0){
        
        self.Height = HeightinM;

    } else {
        
        self.Height = HeightinM; //////////IMPLEMENT THE CONVERSION INTO ft
    }
    
    if (self.WeightType == 0){
        
        self.Weight = WeightinKG;
        
    } else {
        
        self.Weight = WeightinKG; //////////IMPLEMENT THE CONVERSION INTO Lbs
    }
    
    
    
    [self AddToDatabase];
    [self performSegueWithIdentifier:@"DisplayTabs" sender:nil];
}

- (void)AddToDatabase {
    
    NSDictionary *UserInfo = @{@"Name": Name,
                               @"DoB": DoB,
                               @"Height": self.Height,
                               @"Weight": self.Weight};
    
    [UserProfile UpdateUserProfile:UserInfo];
    
}


@end
