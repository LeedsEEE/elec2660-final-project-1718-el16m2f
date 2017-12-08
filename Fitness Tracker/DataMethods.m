//
//  DataMethods.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "DataMethods.h"

@implementation DataMethods

+(void) ACTIVITYAddToDatabase:(CGFloat *)CaloriesToSave :(NSDate *)DateOfActivity {     //When this method is called the values entered for caloriestosave and dateof activity are then saved into the UserActivityData entity
    
    NSDictionary *UserActivityInfo = @{@"calories":[NSNumber numberWithFloat:*CaloriesToSave],
                                       @"date":DateOfActivity};
    
    [UserActivityData UpdateUserActivity:UserActivityInfo];                             //Calls a method within "UserActivityData+CoreDataClass.h" that is used to save the data into core data
    
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
    
    NSFetchRequest *FetchData = [NSFetchRequest fetchRequestWithEntityName:@"UserActivityData"];    //To get data from core data a fetch request must be made to search in the correct entity which in this case is "UserAdctivityData"
    
    //Reference:
    //https://stackoverflow.com/questions/7304257/coredata-error-data-fault
    [FetchData setReturnsObjectsAsFaults:NO];                                                       //When debugging this allows you to hover over the array that the fetch goes to and then see the data inside without displaying 'fault'
    
    NSError *error;
    NSArray *ActivityData = [context executeFetchRequest:FetchData error:&error];                   //The NSArray activitydata will hold the data returned from the fetch request
    
    //-----Everything under here is to sort the fetched array-----
    
    
    //UserActivityData *EntityData;
    NSMutableArray *CalorieData = [[NSMutableArray alloc]init];                                     //Allocates and initialises and array that is used to save the data into
    
    //Creating a calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDateComponents *CalculationDate = [[NSDateComponents alloc]init];
    NSDate *CurrentDate = [NSDate date];
    
    //SORTING DEFINITION
    /*
    The main issue with sorting this data out is that the user has the ability to make more than one activity entry per day so this algorithm looks at all of the data and if it matche the date of inquiring it will be added to the date. Then the date is added into the array CalorieData. There is 3 different sorting algorithms for each graph view WEEK, MONTH and YEAR.
    */
    if(DateSorting == 1) {                  //-----WEEK-----//
        
        NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
        components.hour = 00;
        NSDate *TodayAtMidnight = [Calendar dateFromComponents:components];                                             //To do any comparisons the date is set to midnight of the day the search is being conducted
        
        for (int i=0 ;i<7; i++){                                                                                        //The for loop runs for the 7 days in a week
            
            CalculationDate.day = (-6+i);                                                                               //Sets the DateComponent for day as -6+i so that it starts last week and works its way up
            
            NSDate *DateToScan = [Calendar dateByAddingComponents:CalculationDate toDate:TodayAtMidnight options:0];    //Creates a date to scan by adding (-6+i) days
            CGFloat DayCalories = 0.0;                                                                                  //Resets the calories found to 0 to make sure it doesn't interfer with data collection
            
            for(int a=0 ; a < [ActivityData count] ; a++){                                                              //A for loop that runs for the count of all data found from the fetch request.
                
                NSArray *IndividulEntryData = [ActivityData objectAtIndex:a];                                           //Returns the first item saved into core data into IndividulDataEntry
                
                if (DateToScan == [IndividulEntryData valueForKey:@"date"]) {                                           //An If statemnet to see if the date value found in the core data entry matches DayToScan
                    DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);             //If theres a match it adds whatever was previously held in day calories and the calories found in the data entry
                }
            }
            [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];                                             //Once all the values have been checked for their date the amount of calories on that day is added to an array
        }
        return CalorieData;                                                                                             //Once the sort has finished created array is returned to whereever this method was called.
        
        
    }else if(DateSorting == 2) {            //-----MONTH-----//                                                         //This algorithm is very similar to the day except for a few exceptions, mostly that we are searching in a range now
        
        NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:CurrentDate];
        components.hour = 00;
        components.day = 1;
        NSDate *FirstDayOfMonth = [Calendar dateFromComponents:components];                                             //Creates a custom day which is the first day of the current month
        
        for (int i=0 ;i<5; i++){                                                                                        //The for loop runs 5 times to create an array with 5 entries
            
            CalculationDate.day = (i*7);
            NSDate *DateToScanLowerBounds = [Calendar dateByAddingComponents:CalculationDate toDate:FirstDayOfMonth options:0];         //A lower scan date is made by looking at the firstdayofthemonth and adding (i*7) days to it
            CalculationDate.day = ((i+1)*7);
            NSDate *DateToScanUpperBounds = [Calendar dateByAddingComponents:CalculationDate toDate:FirstDayOfMonth options:0];         //A upper scan date is made by looking at the firstdayofthemonth and adding ((i+1)*7) days to it
                                                                                                                                        //By doing this its creating a week period to search in
            CGFloat DayCalories = 0.0;
            
            for(int a=0 ; a < [ActivityData count] ; a++){
                
                NSArray *IndividulEntryData = [ActivityData objectAtIndex:a];
                
                if (DateToScanLowerBounds <= [IndividulEntryData valueForKey:@"date"] && DateToScanUpperBounds > [IndividulEntryData valueForKey:@"date"]) {
                    //If the date found in the data entry is greater than or equal to the lower bounds AND its less the the upper vounds then the data will be added to the variable DayCalories
                    
                    DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);
                }
            }
            [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];
        }
        return CalorieData;
        
        
    }else if (DateSorting == 3){            //-----YEAR-----//                                                          //This algorithm is identical to the month algorithm but the dates to search between are different
        
        NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:CurrentDate];
        components.hour = 00;
        components.day = 31;
        NSDate *LastDayOfCurrentMonth = [Calendar dateFromComponents:components];                                       //Creates a NSDate whose value is the last day of the current month;
        
        for (int i=0 ;i<12; i++){
            
            CalculationDate.month = (i-12);
            NSDate *FirstDayOfTheSearchingMonth = [Calendar dateByAddingComponents:CalculationDate toDate:LastDayOfCurrentMonth options:0];
            CalculationDate.month = (i-11);
            NSDate *LastDayOfTheSearchingMonth = [Calendar dateByAddingComponents:CalculationDate toDate:LastDayOfCurrentMonth options:0];
            
            //The boundaries that are made are done so that the search is conducted from the last day of the month before and the last day of the month the data is searching
            
            CGFloat DayCalories = 0.0;
            
            for(int a=0 ; a < [ActivityData count] ; a++){
                
                NSArray *IndividulEntryData = [ActivityData objectAtIndex:a];
                
                if (FirstDayOfTheSearchingMonth < [IndividulEntryData valueForKey:@"date"] && LastDayOfTheSearchingMonth >= [IndividulEntryData valueForKey:@"date"]) {
                    
                    //If the date found in the data entry is greater than the Last day of the previous month AND less than or equal to the last day of the searching month the data will be added to the variable DayCalories
                    
                    DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);
                }
            }
            [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];
        }
        return CalorieData;
        
    }else{          //If the user didn't a valid numebr the  outputted array will have a nil value
        return nil;
    }
    
}



+(void)WEIGHTAddToDatabase:(CGFloat *)WeightToSave :(NSDate *)DateOfRecording {         ////When this method is called the values entered for caloriestosave and dateof activity are then saved into the UserWeightData entity
    
    NSDictionary *UserWeightInfo = @{@"weight":[NSNumber numberWithFloat:*WeightToSave],
                                       @"data":DateOfRecording};                        //DATE WAS SPELT WRONG, where data is used it is supposed to mean date
    
    [UserWeightData UpdateUserWeightActivity:UserWeightInfo];                           //Calls a method within "UserWeightData+CoreDataClass.h" that is used to save the data into core data
    
}


+(NSArray *)GetWeightDataFromCoreData:(BOOL)PreviousWeek {
    
    /*
    //If the bool is:
    // TRUE = Show previous week recordings
    // FALSE = Show current week recordings
    */
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *FetchData = [NSFetchRequest fetchRequestWithEntityName:@"UserWeightData"];
    
    //Reference:
    //https://stackoverflow.com/questions/7304257/coredata-error-data-fault
    [FetchData setReturnsObjectsAsFaults:NO];                                                       //When debugging this allows you to hover over the array that the fetch goes to and then see the data inside without displaying 'fault'
    
    NSError *error;
    NSArray *FetchedWeightData = [context executeFetchRequest:FetchData error:&error];              //The data fetched from the fetch request is stored int the array FetchedWeightData
    
    //-----Everything under here is to sort the fetched array-----
    
    
    //UserActivityData *EntityData;
    NSMutableArray *WeightData = [[NSMutableArray alloc]init];
    
    //Creating a calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDateComponents *CalculationDate = [[NSDateComponents alloc]init];
    NSDate *CurrentDate = [NSDate date];
    NSInteger CountFrom;
    
    NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
    components.hour = 00;
    NSDate *FirstDayOfWeek = [Calendar dateFromComponents:components];
    
    CGFloat WeightForDay = 0.0;
    BOOL DataFound = NO;
    
    if(!PreviousWeek){              //Count from defines what day the sort will start counting from. Either 6 days ago or 13 days ago
        CountFrom = -6;
    }else{
        CountFrom = -13;
    }
    //Sorting Description
    /*
    When sorting through the weight data there are two different ranges it should seach between; the current week and the past week. One issue found is that if there is no entry on a day the line graph will be set to zero which ruins the look of the graph. To fix this the sort will set the value of weight for the day to the most recent weight recording outside of the search area. It also means that mid-week the values will be set to the data most recent to it. If you made a data entry 2 days ago of 85KG the line graph will show the data for a day ago and today and 85KG.
    */
    
    for(int i=0;i<7;i++){                                                                                               //A for loop running 7 times for 7 days to rearrange data into date order.
        
        CalculationDate.day = (CountFrom+i);                                                                            //Increases the day component by i each pass
        NSDate *SearchDate = [Calendar dateByAddingComponents:CalculationDate toDate:FirstDayOfWeek options:0];         //Creates an NSDate to conduct the search from
        
        for( NSUInteger a=([FetchedWeightData count]) ; a > 0 && !DataFound ; a-- ){                                    //A for loop used to find the most recent data entry outside of the search criteria, it counts down from the count of the array. If any data was found here before this for loop is not cinducted again
            
            NSArray *IndividualWeightEntry = [FetchedWeightData objectAtIndex:(a-1)];                                   //To return the data foudn here we need to look at the object at index [a-1] otherwise we may be scanning outside the arrays indexes
            
            if([[IndividualWeightEntry valueForKey:@"weight"]floatValue] != 0 && SearchDate > [IndividualWeightEntry valueForKey:@"data"]){
                
                //If the data found doesn't equal zero and the date of the entry is less than the search date then the programme has found the most recent data entry
                
                WeightForDay = [[[FetchedWeightData objectAtIndex:(a-1)]valueForKey:@"weight"]floatValue];              //This sets the intial 'WeightForDay' value
                DataFound = YES;
            }
        }
        
        
        //Sorts the data into an array
        for(int a=0;a<[FetchedWeightData count];a++){                                                                   //The for loops sorts through all the data within the data base to use
                
            NSArray *IndividualWeightEntry = [FetchedWeightData objectAtIndex:a];                                       //This returns the value in the fetched data at index a into an array IndividualWeightEntry
                
            if(SearchDate == [IndividualWeightEntry valueForKey:@"data"]){                                              //If the date of the data found is identical to the date of search than check to see if there is a value found
                
                if([[IndividualWeightEntry valueForKey:@"weight"]floatValue] != 0){                                     //If the weight isn't a 0 value then the WeightForDay will be set to  the value in the data entry. If not the value for that day will be set the previous value of WeightForDay, since WeightForDay isn't reset the value for the day will be set to whatever was the most recent data entry.
                    WeightForDay = [[IndividualWeightEntry valueForKey:@"weight"]floatValue];
                }
            }
        }
        [WeightData addObject:[NSNumber numberWithFloat:WeightForDay]];
    }
        
    return WeightData;
    
}


+(NSDate *)DateOfMostRecentWeightSave {                                                             //This method is made for the Add Weight tab so that the programme can see if the user has entered any data on the current date
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *FetchData = [NSFetchRequest fetchRequestWithEntityName:@"UserWeightData"];
    [FetchData setReturnsObjectsAsFaults:NO];                                                       //When debugging this allows you to hover over the array that the fetch goes to and then see the data inside without displaying 'fault'
    
    NSError *error;
    NSArray *FetchedWeightData = [context executeFetchRequest:FetchData error:&error];
    
    return [[FetchedWeightData objectAtIndex:([FetchedWeightData count]-1)]valueForKey:@"data"];    //The method will return the data that was most recently entered, which will be in the last index of the fetched array.
}


@end
