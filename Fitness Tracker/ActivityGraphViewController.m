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


@end

@implementation ActivityGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Creating time objects and creating formats for the X-axis labels
    CurrentDate = [NSDate date];
    
    //Creating locales to format the date into a GB format
    //Refernce:
    //https://www.cocoawithlove.com/2009/05/simple-methods-for-date-formatting-and.html
    NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    WordedDayFormat = [[NSDateFormatter alloc]init];
    [WordedDayFormat setLocale:Locale];
    [WordedDayFormat setDateFormat:@"E"];               //this formats the date into a format like so: Mon,Tue,Wed etc
    
    WordedMonthFormat = [[NSDateFormatter alloc]init];
    [WordedMonthFormat setLocale:Locale];
    [WordedMonthFormat setDateFormat:@"MMMM-YY"];       //this formats the date into a format like so: January-2017, February-2017 etc
    
    //Initialising the graphs size. If this is not done the graph loads with an incorrect size. If this isn't implemented simply refreshing the graph will bring it to a correct size
    CGRect frame = self.ActivityBarChart.frame;
    UIViewController *WeightGraphViewController = [[UIViewController alloc]init];
    CGSize PhoneScreenSize = WeightGraphViewController.view.frame.size;
    frame.size.width = (PhoneScreenSize.width-10);             //Width subtracting the constraint size
    float z = 190;
    frame.size.height = (PhoneScreenSize.height-z);           //The value of z determines the height of the graph.
    self.ActivityBarChart.frame = frame;
    
    self.BarValueLabel.text = [NSString stringWithFormat:@"Touch on the bars"];
    
    //[self initFAKEdata];                                                                                                          //***[FAKEDATA]***
    
    [self GraphRefresh];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.ActivityBarChart setState:JBChartViewStateExpanded];
    
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    //When the screen is orientated this method will be called
    //Method found at: http://pinkstone.co.uk/how-to-handle-device-rotation-since-ios-8/
    
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(GraphRefresh) userInfo:nil repeats:NO];     //An NSTimer was used as if it wasn't the chart would re-scale to some value inbetween vertical and horizontal

}

-(BOOL)prefersStatusBarHidden {
    return YES;                                                                 //This function removes the status bar, as it was getting in the way.
    //Reference:
    //https://stackoverflow.com/questions/32965610/hide-the-status-bar-in-ios-9
}

#pragma mark Function to move to the profile screen if this is the users first time!

-(void)viewDidAppear:(BOOL)animated {
    
    NSNumber *ShowProfileScreen = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserFirstTime"];
    
    if(ShowProfileScreen == nil) {                                              //The if statement asks if there is any NSUserDefaults data and if there isn't, it is because it's the users first time loading the app.
        
        [self performSegueWithIdentifier:@"ShowProfileSetup" sender:nil];       //This segue is performed if its the users first time and will take the user to a profile creation screen

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

-(UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView {                   //This method asks what color the selector will appear when bars are hovered over.
    return [UIColor whiteColor];
}

-(UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index {
    
    if ((index%2) == 1){                                                                        //This if statement means that the color of the bars are alternating
        return [UIColor orangeColor];                                                           //Creates bars of an orange color
    } else {
        return [UIColor colorWithRed:0.40 green:0.15 blue:0.20 alpha:0.9];                      //Creates bars of a dark red color
    }
    
}

-(void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index {
    self.BarValueLabel.text = [NSString stringWithFormat:@"%.0f Calories",[[ChartData objectAtIndex:index]floatValue]];         //When a bar is selected a string is shown with the value contained in that bar
}

-(void)didDeselectBarChartView:(JBBarChartView *)barChartView {
    self.BarValueLabel.text = [NSString stringWithFormat:@" "];                                                                 //When the bar is let go the label is changed to be blank
}

#pragma mark Segmented Control

//This function alters the data that is going to be displayed based on the value of the Segmented Contorl
-(void) SegmentedControlModifyData {
    
    if (self.BarChartType.selectedSegmentIndex == 0){
        
        ChartData = [DataMethods GetActivityDataFromCoreData:1];                    //-----FETCHES WEEK DATA-----//             //***[COREDATA]***
        //ChartData = WeekData;                                                                                                 //***[FAKEDATA]***
        
        NSDateComponents *singularday = [[NSDateComponents alloc] init];
        singularday.day = -6;                                                       //These two lines create a component of -6 days so that the far left label shows the day from a week ago.
        
        NSCalendar *Calendar = [NSCalendar currentCalendar];
        NSDate *TomorrowDay = [Calendar dateByAddingComponents:singularday toDate:CurrentDate options:0];
        
        ChartLabels = [NSArray arrayWithObjects:
                       [WordedDayFormat stringFromDate:TomorrowDay],
                       @"Today", nil];                                              //The array chart lables is given two values to display on the x-axis. This is the same for other data ie. Month and Year
        
    } else if (self.BarChartType.selectedSegmentIndex ==1){
        
        ChartData = [DataMethods GetActivityDataFromCoreData:2];                    //-----FETCHES MONTH DATA-----//            //***[COREDATA]***
        //ChartData = MonthData;                                                                                                //***[FAKEDATA]***
        
        ChartLabels = [NSArray arrayWithObjects:
                       @"Week 1",
                       @"Week 5", nil];
        
    } else {
        
        ChartData = [DataMethods GetActivityDataFromCoreData:3];                    //-----FETCHES YEAR DATA-----//             //***[COREDATA]***
        //ChartData = YearData;                                                                                                 //***[FAKEDATA]***
        
        NSDateComponents *elevenmonths = [[NSDateComponents alloc] init];
        elevenmonths.month = -11;                                                    //These two lines create a component of -11 months so that the graphs label displays the correct month with its year
        
        NSCalendar *Calendar = [NSCalendar currentCalendar];
        NSDate *TomorrowDay = [Calendar dateByAddingComponents:elevenmonths toDate:CurrentDate options:0];
        
        ChartLabels = [NSArray arrayWithObjects:
                       [WordedMonthFormat stringFromDate:TomorrowDay],
                       [WordedMonthFormat stringFromDate:CurrentDate], nil];
        
    }
    
}

//When the segmented control is changed the following functions are called.
- (IBAction)SegmentedControlChanged:(id)sender {

    [self SegmentedControlModifyData];
    [self UpdateData];
    
    //Reload chart inserts the data into the chart. Setting reloadanimated to yes means that when the data is reloaded its animated in.
    [self.ActivityBarChart reloadDataAnimated:YES];
    
}

#pragma mark Additional functions

//This is required to initialize the view. Its updates the Data. Updates the bounds of the graph. Then reloads onto the graph.
-(void) GraphRefresh {
    
    [self SegmentedControlModifyData];
    [self UpdateData];
    [self.ActivityBarChart reloadDataAnimated:YES];
    
}

-(void) initFAKEdata {
    
    WeekData = [NSArray arrayWithObjects:
                @400,@450,@380,@525,@125,@0,@250, nil];
    MonthData = [NSArray arrayWithObjects:
                 @2130,@2320,@1975,@2230,@865, nil];
    YearData = [NSArray arrayWithObjects:
                @6800,@7250,@7880,@8821,@8492,@8484,@8797,@8491,@8190,@7662,@7768,@9040, nil];
    
    
}

-(void) UpdateData {
    
    //All the methods below are used to create the bounds of the chart  including the background color and the chart labels
    
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
