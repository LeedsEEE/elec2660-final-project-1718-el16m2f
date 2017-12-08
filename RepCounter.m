//
//  RepCounter.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 20/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "RepCounter.h"

@interface RepCounter ()

@end

@implementation RepCounter

- (void)viewDidLoad {
    [super viewDidLoad];

    //When the load is loaded for the first time it is initalised.
    [self initview];
    
    //The layer.cornerRadius allows the corners of the reset button to be made more rounded for a better look.
    //Reference:
    //https://stackoverflow.com/questions/22601584/change-the-shape-of-button
    self.ResetButton.layer.cornerRadius = 22;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    //When the view is left the the tab resets. This prevents the tab from running in the background.
    
    [self initview];
    
    //[Timer invalidate] stops the timer from running
    [Timer invalidate];
    
    Timer = nil;
}

    //When the reset button is pressed the view is reset to it's starting state.
- (IBAction)ResetButtonPressed:(UIButton *)sender{
    
    [self initview];
    
    [Timer invalidate];
    Timer = nil;
    
}

- (IBAction)BackgroundPressed:(id)sender {
    
    Counts++;                                                                       //Everytime the background is pressed the counts increase by 1 each time.
    self.CounterLabel.text = [NSString stringWithFormat:@"%li",(long)Counts];       //The label will update with each background press to show the counts
    
    if (Running == NO){
        Running = YES;                                                              //If the timer isn't running yet, this tells the timer to start running'
        
        if(Timer == nil) {                                                          //If the timer was invalidated the timer is now set to start runnning when the background is pressed.

            Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(UpdateTimer) userInfo:nil repeats:YES];         //After every 0.01 seconds the function UpdateTimer is called to change the value of the timer label
        }
    }
}

-(void)initview {
    
    //A method created to initialise the view by setting the time and counts to 0 and setting the timer to not running. It also sets the labels to their equivilant of 0
    
    Counts = 0;
    Running = NO;
    Time = 0;
    
    self.TimerLabel.text = [NSString stringWithFormat:@"00:00.00"];
    self.CounterLabel.text = [NSString stringWithFormat:@"0"];
    
}

#pragma mark Update timer function
- (void)UpdateTimer {
    
    //This method updates the label where the time is displayed. 1 unit of the variable time is equivilant to 0.01 seconds
    
    Time++;
    
    int Minutes = floor(Time/100/60);
    int Seconds = floor(Time/100);
    int MilliSeconds = Time % 100;
    
    if (Seconds >= 60){                 //If the count of the seconds is greater than or equal to 60 then the seconds will then be counted by doing modulus 60 of the seconds so they carry on counting. This is easier than doing (-60*i) for each pass
        Seconds = Seconds % 60;
    }
    self.TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d.%02d",Minutes,Seconds,MilliSeconds];
}

@end
