//
//  UserActivityData+CoreDataClass.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserActivityData : NSManagedObject

+ (UserActivityData *)UpdateUserActivity:(NSDictionary *)UserActivityInfo;

@end

NS_ASSUME_NONNULL_END

#import "UserActivityData+CoreDataProperties.h"
