//
//  UserActivityData+CoreDataProperties.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserActivityData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserActivityData (CoreDataProperties)

+ (NSFetchRequest<UserActivityData *> *)fetchRequest;

@property (nonatomic) NSNumber *activityID;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) NSNumber *calories;

@end

NS_ASSUME_NONNULL_END
