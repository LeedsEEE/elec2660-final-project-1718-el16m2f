//
//  UserActivityData+CoreDataProperties.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserActivityData+CoreDataProperties.h"

@implementation UserActivityData (CoreDataProperties)

+ (NSFetchRequest<UserActivityData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserActivityData"];
}

@dynamic activityID;
@dynamic date;
@dynamic calories;

@end
