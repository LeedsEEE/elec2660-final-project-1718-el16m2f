//
//  UserProfile+CoreDataClass.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 01/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserProfile+CoreDataClass.h"
#import "AppDelegate.h"

@implementation UserProfile

+ (UserProfile *)UpdateUserProfile:(NSDictionary *)UserInformation{
    
    AppDelegate *applicationdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = applicationdelegate.persistentContainer.viewContext;
    
    UserProfile *UserEntity = (UserProfile *[NSEntityDescription insertNewObjectForEntityForName:@"UserProfile" inManagedObjectContext:context];
    //Creating a new object
    
    UserEntity.firstName = [UserInformation valueForKey:@"Name"];
    UserEntity.dob = [UserInformation valueForKey:@"DoB"];
    UserEntity.height = [UserInformation valueForKey:@"Height"];
    UserEntity.weight = [UserInformation valueForKey:@"Weight"];
    
    
   
    
    return UserEntity;
    
}



@end
