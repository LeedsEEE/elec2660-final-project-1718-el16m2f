//
//  UserProfile+CoreDataClass.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 01/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfile : NSManagedObject

+ (UserProfile *)UpdateUserProfile:(NSDictionary *)UserInformation;

@end

NS_ASSUME_NONNULL_END

#import "UserProfile+CoreDataProperties.h"
