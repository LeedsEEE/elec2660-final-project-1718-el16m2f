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
    
    UserWeightData *WeightEntity = (UserWeightData *)[NSEntityDescription insertNewObjectForEntityForName:@"UserWeightActivity" inManagedObjectContext:context];
    
    //Creating a new object
    WeightEntity.weightID = [UserWeightInfo valueForKey:@"WeightID"];
    WeightEntity.weight = [UserWeightInfo valueForKey:@"Weight"];
    WeightEntity.data = [UserWeightInfo valueForKey:@"Date"];
    
    return WeightEntity;
    
}

@end
