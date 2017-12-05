//
//  DataMethods.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "DataMethods.h"

@implementation DataMethods

+(NSArray *) GetActivityDataFromCoreData {
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    //UserActivityData *ActivityEntity = (UserActivityData *)[NSEntityDescription insertNewObjectForEntityForName:@"UserActivityData" inManagedObjectContext:context];
    
    NSFetchRequest *FetchData = [NSFetchRequest fetchRequestWithEntityName:@"UserActivityData"];
    
    [FetchData setReturnsObjectsAsFaults:NO];
    
    NSError *error;
    NSArray *ActivityData = [context executeFetchRequest:FetchData error:&error];
    //NSArray *test = [NSArray arrayWithObjects:ActivityData count:[ActivityData count]];
    
    return ActivityData;
}

+(NSArray *) GetWeightDataFromCoreData {
    
    return nil;
}

@end
