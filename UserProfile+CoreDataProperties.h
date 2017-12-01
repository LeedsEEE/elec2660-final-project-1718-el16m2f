//
//  UserProfile+CoreDataProperties.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 01/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "UserProfile+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserProfile (CoreDataProperties)

+ (NSFetchRequest<UserProfile *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dob;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nonatomic) BOOL viewedappbefore;
@property (nonatomic) NSNumber *height;
@property (nullable, nonatomic, copy) NSString *surName;
@property (nonatomic) NSNumber *weight;

@end

NS_ASSUME_NONNULL_END
