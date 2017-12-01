//
//  UserProfile+CoreDataProperties.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 01/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserProfile+CoreDataProperties.h"

@implementation UserProfile (CoreDataProperties)

+ (NSFetchRequest<UserProfile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserProfile"];
}

@dynamic dob;
@dynamic firstName;
@dynamic viewedappbefore;
@dynamic height;
@dynamic surName;
@dynamic weight;

@end
