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

//Methods for the Activity data
+(void) ACTIVITYAddToDatabase:(CGFloat *)CaloriesToSave :(NSDate *)DateOfActivity;

+(NSArray *)GetActivityDataFromCoreData:(int)DateSorting;



//Methods for the Weight data

+(void)WEIGHTAddToDatabase:(CGFloat *)WeightToSave :(NSDate *)DateOfRecording;

+(NSArray *)GetWeightDataFromCoreData:(BOOL)PreviousWeek;

+(NSDate *)DateOfMostRecentWeightSave;

/*
//For all of the core data programming I used some tutorials and a lecture on how files need to be set up the data model and then the methods to save data and then retreive it.
//
//Stanford University – Lecture 10. Core Data: https://www.youtube.com/watch?v=Uia6fMNq5e4 
//Stanford University - Core Data Demo: https://www.youtube.com/watch?v=-4wvf3QjHiM 
//HuxTex – Core Data I part 32: https://www.youtube.com/watch?v=EGO9XBFrZE0&t=1089s
//HuxTex – Core Data II part 33: https://www.youtube.com/watch?v=p_INW9noMDI
*/



@end
