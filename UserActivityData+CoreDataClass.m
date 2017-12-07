//
//  UserActivityData+CoreDataClass.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserActivityData+CoreDataClass.h"

@implementation UserActivityData

+ (UserActivityData *)UpdateUserActivity:(NSDictionary *)UserActivityInfo {
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    UserActivityData *ActivityEntity = (UserActivityData *)[NSEntityDescription insertNewObjectForEntityForName:@"UserActivityData" inManagedObjectContext:context];
    
    NSFetchRequest *fetchrequest = [NSFetchRequest fetchRequestWithEntityName:@"UserActivityData"];
    
    NSError *error;
    NSArray *matchingdata = [context executeFetchRequest:fetchrequest error:&error];
    
    NSInteger NewActivityID = [matchingdata count];
    
    ActivityEntity.activityID = [NSNumber numberWithInteger:NewActivityID];
    ActivityEntity.calories = [UserActivityInfo valueForKey:@"calories"];
    ActivityEntity.date = [UserActivityInfo valueForKey:@"date"];
    
    [context save:nil];
    return ActivityEntity;
    
}

@end
