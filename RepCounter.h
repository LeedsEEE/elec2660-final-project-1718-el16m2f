//
//  RepCounter.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 20/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepCounter : UIViewController
{
    NSInteger Counts;
    BOOL Running;
    NSTimer *Timer;
    NSInteger Time;
}

@property (weak, nonatomic) IBOutlet UILabel *TimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *CounterLabel;
@property (weak, nonatomic) IBOutlet UIButton *ResetButton;

- (IBAction)ResetButtonPressed:(UIButton *)sender;

- (IBAction)BackgroundPressed:(id)sender;

- (void)UpdateTimer;

@end
