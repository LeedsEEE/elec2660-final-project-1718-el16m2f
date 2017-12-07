//
//  WeightGraphController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 28/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "WeightGraphController.h"
#import "DataMethods.h"

@interface WeightGraphController ()

@end

@implementation WeightGraphController

- (void)viewDidLoad {
    
    [self ResetLabels];
    
    //Creating locales to format the date into a GB format
    //Reference
    //https://www.cocoawithlove.com/2009/05/simple-methods-for-date-formatting-and.html
    NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    WordedDayFormat = [[NSDateFormatter alloc]init];
    [WordedDayFormat setLocale:Locale];
    [WordedDayFormat setDateFormat:@"E"];
    
    //Initialising the graphs size. If this is not done the graph loads with an incorrect size. If this isn't implemented simply refreshing the graph will bring it to a correct size
    CGRect frame = self.LineChart.frame;
    UIViewController *WeightGraphViewController = [[UIViewController alloc]init];
    CGSize PhoneScreenSize = WeightGraphViewController.view.frame.size;
    frame.size.width = (PhoneScreenSize.width-0);             //Width subtracting the constraint size
    float z = 93;
    frame.size.height = (PhoneScreenSize.height-z);           //The value of z determines the height of the graph. 
    self.LineChart.frame = frame;
    
    [self GraphRefresh];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.LineChart setState:JBChartViewStateExpanded];
}

-(void)viewDidAppear:(BOOL)animated{
    [self GraphRefresh];                                      //The graph is refreshed here so everytime the viewed is presented the data is automatically updated
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {         //Same as the method adopted in the activity graph to make sure the graph resizes upon load
    
    //Method found at: http://pinkstone.co.uk/how-to-handle-device-rotation-since-ios-8/
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(GraphRefresh) userInfo:nil repeats:NO];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
    //Method used to hide the status bar
    //https://stackoverflow.com/questions/32965610/hide-the-status-bar-in-ios-9
}

#pragma mark Line Chart Data source
-(NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {                                                                                //Sets the number of lines within the chart
    return 2;
}

-(NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {                                       //Sets the number of dots on the line to the count of the array.
    if (lineIndex == 0){
        return [WeekData count];
    } else if (lineIndex == 1){
        return [PreviousWeekData count];
    } else {
        return 0;
    }
}

-(CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {    //Sets the Y-axis value of data.
    
    if (lineIndex == 0){
        return [[WeekData objectAtIndex:horizontalIndex] floatValue];
    } else if (lineIndex == 1){
        return [[PreviousWeekData objectAtIndex:horizontalIndex]floatValue];
    } else {
        return 0;
    }
}

#pragma mark Line Chart Delegate


#pragma mark Setting the color of the lines within the chart
-(UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    if (lineIndex == 0){
        return [UIColor colorWithRed:1 green:0.294 blue:0.294 alpha:0.9];           //Red color
    } if (lineIndex == 1){
        return [UIColor colorWithRed:1 green:0.6 blue:0.2 alpha:0.9];               //Orange color
    }
    return 0;                                                                       //Set the color of the lines
}


-(UIColor *)lineChartView:(JBLineChartView *)lineChartView fillColorForLineAtLineIndex:(NSUInteger)lineIndex {

    if (lineIndex == 0){
        return [UIColor colorWithRed:1 green:0.4 blue:0.4 alpha:0.6];               //Red color
    } else if(lineIndex == 1){
        return [UIColor colorWithRed:1 green:0.69803 blue:0.4 alpha:0.5];           //Orange color
    } else {
        return nil;                                                                 //Set the fill color that appears under the line
    }
    
}

-(BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex {
    return false;                                                                   //True - The lines will be smooth. False - the lines will be straight.
}


#pragma mark Changing the looks of the data dots
-(BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex {
    return true;                                                                    //If true the line will be presented with data points
}

-(UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];                   //Set the color of the data points
}
-(CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return 4.5;                                                                     //Set the radius of the points
}


#pragma mark Actions for when a data set is clicked on
-(void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex {
    
    CurrentDate = [NSDate date];
    
    NSDateComponents *MinusSixDays = [[NSDateComponents alloc] init];
    MinusSixDays.day = -6;
    NSDateComponents *MinusSevenDays = [[NSDateComponents alloc] init];
    MinusSevenDays.day = -7;
    NSDateComponents *MinusThirteenDays = [[NSDateComponents alloc] init];
    MinusThirteenDays.day = -13;
    
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    
    if(lineIndex == 0){                     //If the data selected is current week it will show current week labels but if its the previous week the label will change to match this
        
        self.TypeOfWeek.text = [NSString stringWithFormat:@"Current week"];
        self.ChartValue.text = [NSString stringWithFormat:@"%.0f Kgs", [[WeekData objectAtIndex:horizontalIndex]floatValue]];
        
        self.RightChartFooter.text = [NSString stringWithFormat:@"Today"];
        self.LeftChartFooter.text = [WordedDayFormat stringFromDate:[Calendar dateByAddingComponents:MinusSixDays toDate:CurrentDate options:0]];
        
        
    } else if(lineIndex == 1){
        
        self.TypeOfWeek.text = [NSString stringWithFormat:@"Last week"];
        self.ChartValue.text = [NSString stringWithFormat:@"%.0f Kgs", [[PreviousWeekData objectAtIndex:horizontalIndex]floatValue]];
        
        self.RightChartFooter.text = [WordedDayFormat stringFromDate:[Calendar dateByAddingComponents:MinusSevenDays toDate:CurrentDate options:0]];
        self.LeftChartFooter.text = [WordedDayFormat stringFromDate:[Calendar dateByAddingComponents:MinusThirteenDays toDate:CurrentDate options:0]];
        
    }
}

-(void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView {
    
    [self ResetLabels];
    
}

-(void) ResetLabels {
    
    self.TypeOfWeek.text = [NSString stringWithFormat:@"Weight Tracker"];
    self.ChartValue.text = [NSString stringWithFormat:@"Click on the graph"];
    self.RightChartFooter.text = [NSString stringWithFormat:@""];
    self.LeftChartFooter.text = [NSString stringWithFormat:@""];
    
}

-(void)GraphRefresh {
    
    WeekData = [DataMethods GetWeightDataFromCoreData:false];           //By entering false it returns the current week
    PreviousWeekData = [DataMethods GetWeightDataFromCoreData:true];    //By entering true it returns the previous week
    [self UpdateData];
    [self.LineChart reloadDataAnimated:YES];
    
}

-(void) UpdateData {
    
    self.LineChart.delegate = self;
    self.LineChart.dataSource = self;
    
    //These values need initialising before going through the for loop
    float MaxValue = 0.0;
    float MinValue = 10000.0;
    
    NSArray *Allthedata = [WeekData arrayByAddingObjectsFromArray:PreviousWeekData];
    
    for(int i = 0 ; i < ([Allthedata count]) ; i++){                    //Finds the Min and Max values so that graph will display data between the min and max rather than 0 and max
        if([[Allthedata objectAtIndex:i] floatValue] > MaxValue){
            MaxValue = [[Allthedata objectAtIndex:i]floatValue];
        }else if([[Allthedata objectAtIndex:i]floatValue] < MinValue){
            MinValue = [[Allthedata objectAtIndex:i]floatValue];
        }
    }

    //Sets boundary values of the chart
    self.LineChart.minimumValue = (MinValue*0.975);
    self.LineChart.maximumValue = (MaxValue);
    
    self.LineChart.headerPadding = 70;
    self.LineChart.footerPadding = 50;
    
    [self.LineChart reloadDataAnimated:YES];
}

@end
