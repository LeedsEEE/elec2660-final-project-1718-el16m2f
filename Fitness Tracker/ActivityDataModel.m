//
//  ActivityDataModel.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "ActivityDataModel.h"

@implementation ActivityDataModel

-(instancetype) init;

{
    self = [super init];
    
    if (self){
    
        self.ActivityList = [NSMutableArray array];
        
        /*
        //ActivityInfo *'SomeActivity' = allocate and initialise the event before adding to it
        //'SomeActivity'.ActivityID = Creates an id that can be used
        //'SomeActivity'.Activity = Allows a name to be set as a string for a title of the event
        //'SomeActivity'.CalorieRate = Sets the calories burnt per hour so calculations can be carried out
        */
        
        ActivityInfo *Jogging = [[ActivityInfo alloc]init];
        Jogging.ActivityID = 1;
        Jogging.Activity = @"Jogging";
        Jogging.CalorieRate = 398;
        
        ActivityInfo *Running = [[ActivityInfo alloc]init];
        Running.ActivityID = 2;
        Running.Activity = @"Running";
        Running.CalorieRate = 557;
        
        ActivityInfo *SwimmingBreaststroke = [[ActivityInfo alloc]init];
        SwimmingBreaststroke.ActivityID = 3;
        SwimmingBreaststroke.Activity = @"Swimming - Breaststroke";
        SwimmingBreaststroke.CalorieRate = 585;
        
        ActivityInfo *SwimmingButterfly = [[ActivityInfo alloc]init];
        SwimmingButterfly.ActivityID = 4;
        SwimmingButterfly.Activity = @"Swimming - Butterfly";
        SwimmingButterfly.CalorieRate = 784;
        
        ActivityInfo *Cycling = [[ActivityInfo alloc]init];
        Cycling.ActivityID = 5;
        Cycling.Activity = @"Cycling";
        Cycling.CalorieRate = 398;
        
        ActivityInfo *Rowing = [[ActivityInfo alloc]init];
        Rowing.ActivityID = 6;
        Rowing.Activity = @"Rowing";
        Rowing.CalorieRate = 682;
        
        ActivityInfo *Squash = [[ActivityInfo alloc]init];
        Squash.ActivityID = 7;
        Squash.Activity = @"Squash";
        Squash.CalorieRate = 748;
        
        [self.ActivityList addObject:Jogging];                  //Index 0
        [self.ActivityList addObject:Running];                  //Index 1
        [self.ActivityList addObject:SwimmingBreaststroke];     //Index 2
        [self.ActivityList addObject:SwimmingButterfly];
        [self.ActivityList addObject:Cycling];
        [self.ActivityList addObject:Rowing];
        [self.ActivityList addObject:Squash];
        
    }
    
    return self;
    
}



@end
