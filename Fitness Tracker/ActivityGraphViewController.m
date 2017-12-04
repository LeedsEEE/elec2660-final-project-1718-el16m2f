//
//  ActivityGraphViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "ActivityGraphViewController.h"

@interface ActivityGraphViewController ()
{
    NSArray *ChartData;
    NSArray *ChartLabels;

    NSArray *WeekData;
    NSArray *MonthData;
    NSArray *YearData;
    NSArray *DaysInAWeek;
    NSArray *WeeksInAMonth;
    
    NSDate *CurrentDate;
    
    NSDateFormatter *WordedDayFormat;
    NSDateFormatter *WordedMonthFormat;
}

@end

@implementation ActivityGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Creating time objects and creating formats for the X-axis labels
    CurrentDate = [NSDate date];
    
    NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    WordedDayFormat = [[NSDateFormatter alloc]init];
    [WordedDayFormat setLocale:Locale];
    [WordedDayFormat setDateFormat:@"E"];
    
    WordedMonthFormat = [[NSDateFormatter alloc]init];
    [WordedMonthFormat setLocale:Locale];
    [WordedMonthFormat setDateFormat:@"MMMM-YY"];
    
    //Some test data
    WeekData = [NSArray arrayWithObjects:
                            @20,@30,@40,@35,@25,@45,@30, nil];
    MonthData = [NSArray arrayWithObjects:
                            @500,@600,@550,@400,@475, nil];
    YearData = [NSArray arrayWithObjects:
                            @2000,@3000,@2500,@3250,@3112,@1750,@3980,@3210,@4100,@2680,@2980,@3650, nil];
    
    DaysInAWeek = [NSArray arrayWithObjects:
                        @"Monday",@"Today", nil];
    
    WeeksInAMonth = [NSArray arrayWithObjects:
                        @"Week1",@"Week5", nil];

    
    self.BarValueLabel.text = [NSString stringWithFormat:@"Touch on the bars"];
    
    [self InitialLoadUp];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.ActivityBarChart setState:JBChartViewStateExpanded];
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;                                                 //This function removes the status bar, as it was getting in the way.
    //https://stackoverflow.com/questions/32965610/hide-the-status-bar-in-ios-9
}

#pragma Function to move to the profile screen if this is the users first time!

-(void)viewDidAppear:(BOOL)animated {
    
    NSNumber *ShowProfileScreen = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserFirstTime"];
    
    if(ShowProfileScreen == nil) {
        
        [self performSegueWithIdentifier:@"ShowProfileSetup" sender:nil];
        
    }
    
}

#pragma Bar Graph delegate methods

-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView {
    
    return [ChartData count];
    
}

-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index {
    
    return [[ChartData objectAtIndex:index]floatValue];
    
}

-(UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView {
    
    return [UIColor whiteColor];
    
}

-(UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index {
    
    if ((index%2) == 1){
        return [UIColor orangeColor];
    } else {
        return [UIColor colorWithRed:1 green:0.6414 blue:0.28 alpha:1];
    }
    
}

-(void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index {
    
    self.BarValueLabel.text = [NSString stringWithFormat:@"%.1f Calories",[[ChartData objectAtIndex:index]floatValue]];
    
}

-(void)didDeselectBarChartView:(JBBarChartView *)barChartView {
    
    self.BarValueLabel.text = [NSString stringWithFormat:@" "];
    
}

#pragma Segmented Control

//This function alters the data that is going to be displayed based on the value of the Segmented Contorl
-(void) SegmentedControlModifyData {
    
    if (self.BarChartType.selectedSegmentIndex == 0){
        
        ChartData = WeekData;
        
        NSDateComponents *singularday = [[NSDateComponents alloc] init];
        singularday.day = -6;                                                    //These two lines create a component of -6 days so that the far left label shows the day from a week ago.
        
        NSCalendar *Calendar = [NSCalendar currentCalendar];
        NSDate *TomorrowDay = [Calendar dateByAddingComponents:singularday toDate:CurrentDate options:0];
        
        ChartLabels = [NSArray arrayWithObjects:
                       [WordedDayFormat stringFromDate:TomorrowDay],
                       @"Today", nil];
        
    } else if (self.BarChartType.selectedSegmentIndex ==1){
        
        ChartData = MonthData;
        ChartLabels = WeeksInAMonth;
        
    } else {
        
        ChartData = YearData;
        
        NSDateComponents *elevenmonths = [[NSDateComponents alloc] init];
        elevenmonths.month = -11;                                                    //These two lines create a component of -11 months so that the graphs label displays the correct month with its year
        
        NSCalendar *Calendar = [NSCalendar currentCalendar];
        NSDate *TomorrowDay = [Calendar dateByAddingComponents:elevenmonths toDate:CurrentDate options:0];
        
        ChartLabels = [NSArray arrayWithObjects:
                       [WordedMonthFormat stringFromDate:TomorrowDay],
                       [WordedMonthFormat stringFromDate:CurrentDate], nil];
        
    }
    
}

- (IBAction)SegmentedControlChanged:(id)sender {

    [self SegmentedControlModifyData];
    [self UpdateData];
    [self.ActivityBarChart reloadDataAnimated:YES];
    
}

#pragma Additional functions

//This is required to initialize the view
-(void) InitialLoadUp {
    
    [self SegmentedControlModifyData];
    [self UpdateData];
    [self.ActivityBarChart reloadDataAnimated:YES];
    
}

-(void) UpdateData {
    
    self.ActivityBarChart.delegate = self;
    self.ActivityBarChart.dataSource = self;
    
    self.ActivityBarChart.minimumValue = 0.0f;
    self.ActivityBarChart.headerPadding = 40.0f;
    self.ActivityBarChart.footerPadding = 0.0f;
    self.ActivityBarChart.backgroundColor = [UIColor lightGrayColor];
    self.ActivityBarChart.inverted = NO;
    
    self.LeftFooterLabel.text = [NSString stringWithFormat:@"%@",[ChartLabels objectAtIndex:0]];
    self.RightFooterLabel.text = [NSString stringWithFormat:@"%@",[ChartLabels objectAtIndex:1]];
    
}

@end
