//
//  ActivityInfo.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityInfo : NSObject

@property NSInteger ActivityID;
@property (nonatomic, strong) NSString *Activity;
@property NSInteger CalorieRate;

@end
