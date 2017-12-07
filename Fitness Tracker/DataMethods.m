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
    [FetchData setReturnsObjectsAsFaults:NO];                                   //When debugging this allows you to hover over the array that the fetch goes to and then see the data inside without displaying 'fault'
    
    NSError *error;
    NSArray *ActivityData = [context executeFetchRequest:FetchData error:&error];
    
    //-----Everything under here is to sort the fetched array-----
    
    
    //UserActivityData *EntityData;
    NSMutableArray *CalorieData = [[NSMutableArray alloc]init];
    
    //Creating a calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDateComponents *CalculationDate = [[NSDateComponents alloc]init];
    NSDate *CurrentDate = [NSDate date];

    
    
    //SORTING DEFINITION
    if(DateSorting == 1) {                  //-----WEEK-----//
        
        NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
        components.hour = 00;
        NSDate *TodayAtMidnight = [Calendar dateFromComponents:components];
        
        for (int i=0 ;i<7; i++){
            
            CalculationDate.day = (-6+i);
            
            NSDate *DateToScan = [Calendar dateByAddingComponents:CalculationDate toDate:TodayAtMidnight options:0];
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
        
        
    }else if(DateSorting == 2) {            //-----MONTH-----//
        
        NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:CurrentDate];
        components.hour = 00;
        components.day = 1;
        NSDate *FirstDayOfMonth = [Calendar dateFromComponents:components];
        
        for (int i=0 ;i<5; i++){
            
            CalculationDate.day = (i*7);
            NSDate *DateToScanLowerBounds = [Calendar dateByAddingComponents:CalculationDate toDate:FirstDayOfMonth options:0];
            CalculationDate.day = ((i+1)*7);
            NSDate *DateToScanUpperBounds = [Calendar dateByAddingComponents:CalculationDate toDate:FirstDayOfMonth options:0];
            
            CGFloat DayCalories = 0.0;
            
            for(int a=0 ; a < [ActivityData count] ; a++){
                
                NSArray *IndividulEntryData = [ActivityData objectAtIndex:a];
                
                if (DateToScanLowerBounds <= [IndividulEntryData valueForKey:@"date"] && DateToScanUpperBounds > [IndividulEntryData valueForKey:@"date"]) {
                    DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);
                }
            }
            [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];
        }
        return CalorieData;
        
        
    }else if (DateSorting == 3){            //-----YEAR-----//
        
        NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:CurrentDate];
        components.hour = 00;
        components.day = 31;
        NSDate *LastDayOfCurrentMonth = [Calendar dateFromComponents:components];
        
        for (int i=0 ;i<12; i++){
            
            CalculationDate.month = (i-12);
            NSDate *FirstDayOfTheSearchingMonth = [Calendar dateByAddingComponents:CalculationDate toDate:LastDayOfCurrentMonth options:0];
            CalculationDate.month = (i-11);
            NSDate *LastDayOfTheSearchingMonth = [Calendar dateByAddingComponents:CalculationDate toDate:LastDayOfCurrentMonth options:0];
            
            CGFloat DayCalories = 0.0;
            
            for(int a=0 ; a < [ActivityData count] ; a++){
                
                NSArray *IndividulEntryData = [ActivityData objectAtIndex:a];
                
                if (FirstDayOfTheSearchingMonth < [IndividulEntryData valueForKey:@"date"] && LastDayOfTheSearchingMonth >= [IndividulEntryData valueForKey:@"date"]) {
                    
                    DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);
                    
                }
            }
            [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];
        }
        return CalorieData;
        
        
    }else{
        
        return nil;
        
    }
    
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
