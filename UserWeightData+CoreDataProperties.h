//
//  UserWeightData+CoreDataProperties.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserWeightData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserWeightData (CoreDataProperties)

+ (NSFetchRequest<UserWeightData *> *)fetchRequest;

@property (nonatomic) NSNumber *weightID;
@property (nonatomic) NSNumber *weight;
@property (nullable, nonatomic, copy) NSDate *data;

//I just noticed that I miss labbeled date by spelling data. When UserWeightData data is being called its refering to the date

@end

NS_ASSUME_NONNULL_END
