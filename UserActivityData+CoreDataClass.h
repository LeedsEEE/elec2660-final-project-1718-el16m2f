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

/*
 //References used for core data:
 //References used to save data
 //HuxTex – Core Data I part 32: https://www.youtube.com/watch?v=EGO9XBFrZE0&t=1089s
 //HuxTex – Core Data II part 33: https://www.youtube.com/watch?v=p_INW9noMDI
 */

