//
//  ActivityGraphViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "ActivityGraphViewController.h"
#import "UserActivityData+CoreDataClass.h"

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
    
    //Initialising the graphs size. If this is not done the graph loads with an incorrect size. If this isn't implemented simply refreshing the graph will bring it to a correct size
    CGRect frame = self.ActivityBarChart.frame;
    UIViewController *WeightGraphViewController = [[UIViewController alloc]init];
    CGSize PhoneScreenSize = WeightGraphViewController.view.frame.size;
    frame.size.width = (PhoneScreenSize.width-10);             //Width subtracting the constraint size
    float z = 190;
    frame.size.height = (PhoneScreenSize.height-z);           //The value of z determines the height of the graph.
    self.ActivityBarChart.frame = frame;
    
    
    [self initfakedata];        //GET RID OF THIS ASAP
    
    WeekData = [self initdata];
    
    self.BarValueLabel.text = [NSString stringWithFormat:@"Touch on the bars"];
    
    [self GraphRefresh];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.ActivityBarChart setState:JBChartViewStateExpanded];
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;                                                 //This function removes the status bar, as it was getting in the way.
    //https://stackoverflow.com/questions/32965610/hide-the-status-bar-in-ios-9
}

#pragma mark Function to move to the profile screen if this is the users first time!

-(void)viewDidAppear:(BOOL)animated {
    NSNumber *ShowProfileScreen = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserFirstTime"];
    if(ShowProfileScreen == nil) {
        [self performSegueWithIdentifier:@"ShowProfileSetup" sender:nil];
    }
    
    [self GraphRefresh];
    
    
}

#pragma mark Bar Graph delegate methods

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
        return [UIColor colorWithRed:1 green:0.294 blue:0.294 alpha:0.6];
    }
    
}

-(void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index {
    
    self.BarValueLabel.text = [NSString stringWithFormat:@"%.1f Calories",[[ChartData objectAtIndex:index]floatValue]];
    
}

-(void)didDeselectBarChartView:(JBBarChartView *)barChartView {
    
    self.BarValueLabel.text = [NSString stringWithFormat:@" "];
    
}

#pragma mark Segmented Control

//This function alters the data that is going to be displayed based on the value of the Segmented Contorl
-(void) SegmentedControlModifyData {
    
    if (self.BarChartType.selectedSegmentIndex == 0){
        
        ChartData = [DataMethods GetActivityDataFromCoreData:1];                    //-----FETCHES WEEK DATA-----//
        
        NSDateComponents *singularday = [[NSDateComponents alloc] init];
        singularday.day = -6;                                                       //These two lines create a component of -6 days so that the far left label shows the day from a week ago.
        
        NSCalendar *Calendar = [NSCalendar currentCalendar];
        NSDate *TomorrowDay = [Calendar dateByAddingComponents:singularday toDate:CurrentDate options:0];
        
        ChartLabels = [NSArray arrayWithObjects:
                       [WordedDayFormat stringFromDate:TomorrowDay],
                       @"Today", nil];
        
    } else if (self.BarChartType.selectedSegmentIndex ==1){
        
        ChartData = [DataMethods GetActivityDataFromCoreData:2];                    //-----FETCHES MONTH DATA-----//
        ChartLabels = WeeksInAMonth;
        
    } else {
        
        ChartData = [DataMethods GetActivityDataFromCoreData:3];                    //-----FETCHES YEAR DATA-----//
        
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
    WeekData = [DataMethods GetActivityDataFromCoreData:1];
    YearData = [DataMethods GetActivityDataFromCoreData:3];
    [self UpdateData];
    [self.ActivityBarChart reloadDataAnimated:YES];
    
}

#pragma mark Additional functions

//This is required to initialize the view. Its updates the Data. Updates the bounds of the graph. Then reloads onto the graph.
-(void) GraphRefresh {
    
    [self SegmentedControlModifyData];
    [self UpdateData];
    [self.ActivityBarChart reloadDataAnimated:YES];
    
}

-(void) initfakedata {
    
    WeekData = [NSArray arrayWithObjects:
                @20.5,@30.2,@40.1,@35.4,@25.9,@45.6,@30.8, nil];
    MonthData = [NSArray arrayWithObjects:
                 @500.5,@600.4,@550.1,@400.0,@475.8, nil];
    YearData = [NSArray arrayWithObjects:
                @2000,@3000,@2500,@3250,@3112,@1750,@3980,@3210,@4100,@2680,@2980,@3650, nil];
/*
    DaysInAWeek = [NSArray arrayWithObjects:
                   @"Monday",@"Today", nil];*/
    
    WeeksInAMonth = [NSArray arrayWithObjects:
                     @"Week1",@"Week5", nil];
    
}

-(NSArray *) initdata {
    ////DO SOME DATA GRABBING HERE
    /*
    NSArray *EntityData = [DataMethods GetActivityDataFromCoreData];
    //UserActivityData *EntityData;
    NSMutableArray *CalorieData = [[NSMutableArray alloc]init];
    
    //Creating a calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    NSDateComponents *PastWeek = [[NSDateComponents alloc]init];
   
    NSDateComponents *components = [Calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:CurrentDate];
    components.hour = 00;
    NSDate *TodayAtMidnight = [Calendar dateFromComponents:components];
    
    for (int i=0 ;i<7; i++){
        
        PastWeek.day = (-6+i);
        NSDate *DateToScan = [Calendar dateByAddingComponents:PastWeek toDate:TodayAtMidnight options:0];
        CGFloat DayCalories = 0.0;
        
        for(int a=0 ; a < [EntityData count] ; a++){
            
            NSArray *IndividulEntryData = [EntityData objectAtIndex:a];
            
            if (DateToScan == [IndividulEntryData valueForKey:@"date"]) {
                DayCalories = (DayCalories + [[IndividulEntryData valueForKey:@"calories"]floatValue]);
            }
            
        }
        
        [CalorieData addObject:[NSNumber numberWithFloat:DayCalories]];
    
    }
    
    NSLog(@"%@",CalorieData);
    */
    
    return nil;
    
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
