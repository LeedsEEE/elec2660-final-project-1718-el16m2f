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
        ActivityInfo *Jogging = [[ActivityInfo alloc]init];
        Jogging.ActivityID = 1;
        Jogging.Activity = @"Jogging";
        Jogging.CalorieRate = 398;
        
        self.ActivityList = [NSMutableArray array];
        ActivityInfo *Running = [[ActivityInfo alloc]init];
        Running.ActivityID = 2;
        Running.Activity = @"Running";
        Running.CalorieRate = 557;
        
        self.ActivityList = [NSMutableArray array];
        ActivityInfo *SwimmingBreaststroke = [[ActivityInfo alloc]init];
        SwimmingBreaststroke.ActivityID = 3;
        SwimmingBreaststroke.Activity = @"Swimming - Breaststroke";
        SwimmingBreaststroke.CalorieRate = 585;
        
        self.ActivityList = [NSMutableArray array];
        ActivityInfo *SwimmingButterfly = [[ActivityInfo alloc]init];
        SwimmingButterfly.ActivityID = 4;
        SwimmingButterfly.Activity = @"Swimming - Butterfly";
        SwimmingButterfly.CalorieRate = 784;
        
        self.ActivityList = [NSMutableArray array];
        ActivityInfo *Cycling = [[ActivityInfo alloc]init];
        Cycling.ActivityID = 5;
        Cycling.Activity = @"Cycling";
        Cycling.CalorieRate = 398;
        
        self.ActivityList = [NSMutableArray array];
        ActivityInfo *Rowing = [[ActivityInfo alloc]init];
        Rowing.ActivityID = 6;
        Rowing.Activity = @"Rowing";
        Rowing.CalorieRate = 682;
        
        self.ActivityList = [NSMutableArray array];
        ActivityInfo *Squash = [[ActivityInfo alloc]init];
        Squash.ActivityID = 7;
        Squash.Activity = @"Squash";
        Squash.CalorieRate = 748;
        
        [self.ActivityList addObject:Jogging];
        [self.ActivityList addObject:Running];
        [self.ActivityList addObject:SwimmingBreaststroke];
        [self.ActivityList addObject:SwimmingButterfly];
        [self.ActivityList addObject:Cycling];
        [self.ActivityList addObject:Rowing];
        [self.ActivityList addObject:Squash];
        
    }
    
    return self;
    
}



@end
