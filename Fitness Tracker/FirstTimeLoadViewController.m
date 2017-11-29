//
//  FirstTimeLoadViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 29/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "FirstTimeLoadViewController.h"

@interface FirstTimeLoadViewController ()

@end

@implementation FirstTimeLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"HasViewedAppBefore"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasviewedappbefore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else {
        
        [self performSegueWithIdentifier:@"DisplayTabs" sender:nil];
        
    }
    
}

- (IBAction)SaveButtonPressed:(id)sender {
        [self performSegueWithIdentifier:@"DisplayTabs" sender:nil];
}


@end
