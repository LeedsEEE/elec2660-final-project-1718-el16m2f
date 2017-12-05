//
//  UserWeightData+CoreDataProperties.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserWeightData+CoreDataProperties.h"

@implementation UserWeightData (CoreDataProperties)

+ (NSFetchRequest<UserWeightData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserWeightData"];
}

@dynamic weightID;
@dynamic weight;
@dynamic data;

@end
