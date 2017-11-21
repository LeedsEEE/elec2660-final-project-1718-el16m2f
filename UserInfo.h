//
//  UserInfo.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *Name;
@property NSInteger DateOfBirth;
@property char Gender;
@property float Height;
@property float Weight;

@end
