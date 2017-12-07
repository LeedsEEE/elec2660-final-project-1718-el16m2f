//
//  UserWeightData+CoreDataClass.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserWeightData+CoreDataClass.h"
#import "AppDelegate.h"

@implementation UserWeightData

+ (UserWeightData *)UpdateUserWeightActivity:(NSDictionary *)UserWeightInfo {
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    UserWeightData *WeightEntity = (UserWeightData *)[NSEntityDescription insertNewObjectForEntityForName:@"UserWeightData" inManagedObjectContext:context];
    
    NSFetchRequest *fetchrequest = [NSFetchRequest fetchRequestWithEntityName:@"UserWeightData"];
    
    NSError *error;
    NSArray *matchingdata = [context executeFetchRequest:fetchrequest error:&error];
    
    NSInteger NewWeightID = [matchingdata count];
    
    //Creating a new object
    WeightEntity.weightID = [NSNumber numberWithInteger:NewWeightID];
    WeightEntity.weight = [UserWeightInfo valueForKey:@"weight"];
    WeightEntity.data = [UserWeightInfo valueForKey:@"data"];
    
    [context save:nil];
    return WeightEntity;
    
}

@end
