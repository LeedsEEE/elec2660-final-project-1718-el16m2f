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
    // Do any additional setup after loading the view initially.
    
    Counts = 0;
    Running = NO;
    Time = 0;
    
    self.TimerLabel.text = [NSString stringWithFormat:@"00:00.00"];
    self.CounterLabel.text = [NSString stringWithFormat:@"0"];
    
    _ResetButton.layer.cornerRadius = 22;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    Counts = 0;
    Running = NO;
    [Timer invalidate];
    Timer = nil;
    Time = 0;
    
    self.TimerLabel.text = [NSString stringWithFormat:@"00:00.00"];
    self.CounterLabel.text = [NSString stringWithFormat:@"0"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ResetButtonPressed:(UIButton *)sender{
    
    Counts = 0;
    self.CounterLabel.text = [NSString stringWithFormat:@"%li",(long)Counts];
    
    Running = NO;
    [Timer invalidate];
    Timer = nil;
    Time = 0;
    self.TimerLabel.text = [NSString stringWithFormat:@"00:00.00"];
    
    
}

- (IBAction)BackgroundPressed:(id)sender {
    
    Counts++;                                       //Increases the count by 1 with each screen press
    self.CounterLabel.text = [NSString stringWithFormat:@"%li",(long)Counts];
    
    if (Running == NO){                             //If the timer isn't runningthis tells the timer to start running'
        Running = YES;
        
        if(Timer == nil) {                          //If the timer wasn't running the timer is now set to start runnning when the background is pressed.
            
            Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(UpdateTimer) userInfo:nil repeats:YES];
            
        }
    }
}

#pragma mark Update timer function
- (void)UpdateTimer {
    
    Time++;
    
    int Minutes = floor(Time/100/60);
    int Seconds = floor(Time/100);
    int MilliSeconds = Time % 100;
    
    if (Seconds >= 60){
        Seconds = Seconds % 60;
    }
    
    
    self.TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d.%02d",Minutes,Seconds,MilliSeconds];
    
}

@end
