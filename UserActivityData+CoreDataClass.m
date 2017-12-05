//
//  UserActivityData+CoreDataClass.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserActivityData+CoreDataClass.h"
#import "AppDelegate.h"

@implementation UserActivityData

+ (UserActivityData *)UpdateUserActivity:(NSDictionary *)UserActivityInfo {
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    //UserActivityData *ActivityEntity = (UserActivityData *)[NSEntityDescription insertNewObjectForEntityForName:@"UserActivity" inManagedObjectContext:context];
    
    UserActivityData *ActivityEntity = nil;
    
    NSString *activityID = UserActivityInfo[@"ActivityID"];
    NSFetchRequest *fetchrequest = [NSFetchRequest fetchRequestWithEntityName:@"UserActivityData"];
    fetchrequest.predicate = [NSPredicate predicateWithFormat:@"ActivityID = %@",activityID];
    
    NSError *error;
    NSArray *matchingdata = [context executeFetchRequest:fetchrequest error:&error];
    
    if (!matchingdata || error || ([matchingdata count] > 1)) {
        //Error handeling
        
    } else if ([matchingdata count]) {
        //Returns the existing entry
        ActivityEntity = [matchingdata firstObject];
        
    } else {
        //Creating a new object
        ActivityEntity.activityID = [UserActivityData valueForKey:@"ActivityID"];
        ActivityEntity.calories = [UserActivityData valueForKey:@"Calories"];
        ActivityEntity.date = [UserActivityData valueForKey:@"Date"];
        
    }
    
    return ActivityEntity;
    
}

@end
