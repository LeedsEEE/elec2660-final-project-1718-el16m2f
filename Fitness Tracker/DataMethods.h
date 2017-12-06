//
//  DataMethods.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 05/12/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserActivityData+CoreDataClass.h"
#import "UserWeightData+CoreDataClass.h"

@interface DataMethods : NSObject

+(NSArray *)GetActivityDataFromCoreData:(int)DateSorting;

+(NSArray *) GetWeightDataFromCoreData;

@end
