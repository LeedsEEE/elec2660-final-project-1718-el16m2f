//
//  DataMethods.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "DataMethods.h"

@implementation DataMethods

+(void) ACTIVITYAddToDatabase:(CGFloat *)CaloriesToSave :(NSDate *)DateOfActivity {
    
    NSDictionary *UserActivityInfo = @{@"calories":[NSNumber numberWithFloat:*CaloriesToSave],
                                       @"date":DateOfActivity};
    
    [UserActivityData UpdateUserActivity:UserActivityInfo];
    
}

+(NSArray *)GetActivityDataFromCoreData:(int)DateSorting {
    
    /*
    //If date sorting is:
    // 1 = Sort data for a week
    // 2 = Sort data for a month
    // 3 = Sort data for a year
    */
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *FetchData = [NSFetchRequest fetchRequestWithEntityName:@"UserActivityData"];
    //FetchData.fetchLimit = 14;
    
    [FetchData setReturnsObjectsAsFaults:NO];
    
    NSError *error;
    NSArray *ActivityData = [context executeFetchRequest:FetchData error:&error];
    
    //return ActivityData;
    
    
    
    //Everything under here is to sort the fetched array
    
    
    
    //UserActivityData *EntityData;
    NSMutableArray *CalorieData = [[NSMutableArray alloc]init];
    
    //Creating a calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDateComponents *PastWeek = [[NSDateComponents alloc]init];
    NSDate *CurrentDate = [NSDate date];
    NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
    components.hour = 00;
    NSDate *TodayAtMidnight = [Calendar dateFromComponents:components];
    
    //SORTING DEFINITION
    int CountTo = 0;
    
    if(DateSorting == 1) {
        CountTo = 7;                    // 7 Days in a week
    }else if(DateSorting == 2) {
        CountTo = 4;                    // 4 Weeks in a month (Sometimes...)
    }else if (DateSorting == 3){
        CountTo = 12;                   // 12 Months in a year
    }else{
        
    }
    
    for (int i=0 ;i<CountTo; i++){
        
        
        PastWeek.day = (-6+i);          //This needs to be in an if statement
        
        
        
        NSDate *DateToScan = [Calendar dateByAddingComponents:PastWeek toDate:TodayAtMidnight options:0];
        CGFloat DayCalories = 0.0;
        
        for(int a=0 ; a < [ActivityData count] ; a++){
            
            NSArray *IndividulEntryData = [ActivityData objectAtIndex:a];
            
            if (DateToScan == [IndividulEntryData valueForKey:@"date"]) {
                DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);
            }
            
        }
        
        [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];
        
    }
    
    return CalorieData;
    
}



+(void)WEIGHTAddToDatabase:(CGFloat *)WeightToSave :(NSDate *)DateOfRecording {
    
    NSDictionary *UserWeightInfo = @{@"weight":[NSNumber numberWithFloat:*WeightToSave],
                                       @"data":DateOfRecording};
    
    [UserWeightData UpdateUserWeightActivity:UserWeightInfo];
    
}

+(NSArray *) GetWeightDataFromCoreData {
    
    return nil;
}


@end
