//
//  WeightGraphController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 28/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "WeightGraphController.h"

@interface WeightGraphController ()
{
    NSArray *ChartData;
    NSArray *ChartLabels;
    
    NSArray *WeekData;
    NSArray *PreviousWeekData;
    
    NSDate *CurrentDate;
    NSDateFormatter *WordedDayFormat;
    
}
@end

@implementation WeightGraphController

- (void)viewDidLoad {
    
    [self ResetLabels];
    
    NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    WordedDayFormat = [[NSDateFormatter alloc]init];
    [WordedDayFormat setLocale:Locale];
    [WordedDayFormat setDateFormat:@"E"];
    
    [self initwithfakedata];
    ChartData = WeekData;
    [self UpdateData];
    [self.LineChart reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.LineChart setState:JBChartViewStateExpanded];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma Line Chart Data source
-(NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {                                                                                //Sets the number of lines within the chart
    
    return 2;
}

-(NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {                                       //Sets the number of dots on the line.
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

#pragma Line Chart Delegate


#pragma Setting the color of the lines within the chart
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


#pragma Changing the looks of the data dots
-(BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex {
    return true;
}

-(UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];       //Set the color of the dots
}
-(CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return 4.5;                                                                     //Set the radius of the dots
}


#pragma Actions for when a data set is clicked on
-(void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex {
    
    CurrentDate = [NSDate date];
    
    NSDateComponents *MinusSixDays = [[NSDateComponents alloc] init];
    MinusSixDays.day = -6;
    NSDateComponents *MinusSevenDays = [[NSDateComponents alloc] init];
    MinusSevenDays.day = -7;
    NSDateComponents *MinusThirteenDays = [[NSDateComponents alloc] init];
    MinusThirteenDays.day = -13;
    
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    
    if(lineIndex == 0){
        
        self.TypeOfWeek.text = [NSString stringWithFormat:@"Current week"];
        self.ChartValue.text = [NSString stringWithFormat:@"%@ Kgs", [WeekData objectAtIndex:horizontalIndex]];
        
        self.RightChartFooter.text = [NSString stringWithFormat:@"Today"];
        self.LeftChartFooter.text = [WordedDayFormat stringFromDate:[Calendar dateByAddingComponents:MinusSixDays toDate:CurrentDate options:0]];
        
        
    } else if(lineIndex == 1){
        
        self.TypeOfWeek.text = [NSString stringWithFormat:@"Last week"];
        self.ChartValue.text = [NSString stringWithFormat:@"%@ Kgs", [PreviousWeekData objectAtIndex:horizontalIndex]];
        
        self.RightChartFooter.text = [WordedDayFormat stringFromDate:[Calendar dateByAddingComponents:MinusSevenDays toDate:CurrentDate options:0]];
        self.LeftChartFooter.text = [WordedDayFormat stringFromDate:[Calendar dateByAddingComponents:MinusThirteenDays toDate:CurrentDate options:0]];
        
    }
}

-(void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView {
    
    [self ResetLabels];
    
}


- (IBAction)RefreshButtonPressed:(id)sender {
    
    [self UpdateData];
    [self.LineChart reloadDataAnimated:YES];
    
}
-(void) initwithfakedata {
    
    WeekData = [NSArray arrayWithObjects:
                @80,@82,@85,@80,@81,@79,@78,@82, nil];
    
    PreviousWeekData = [NSArray arrayWithObjects:
                        @90,@87,@85,@82,@83,@79,@81,@82, nil];
    
}

-(void) ResetLabels {
    
    self.TypeOfWeek.text = [NSString stringWithFormat:@"Weight Tracker"];
    self.ChartValue.text = [NSString stringWithFormat:@"Click on the graph"];
    self.RightChartFooter.text = [NSString stringWithFormat:@""];
    self.LeftChartFooter.text = [NSString stringWithFormat:@""];
    
}

-(void) UpdateData {
    
    self.LineChart.delegate = self;
    self.LineChart.dataSource = self;
    
    //Setting the min and max values of the graph by using the min and max from the data
    float MaxValue = 0.0;
    float MinValue = 10000.0;
    
    NSArray *Allthedata = [WeekData arrayByAddingObjectsFromArray:PreviousWeekData];
    
    for(int i = 0 ; i < ([Allthedata count]) ; i++){
        if([[Allthedata objectAtIndex:i] floatValue] > MaxValue){
            MaxValue = [[Allthedata objectAtIndex:i]floatValue];
        }else if([[Allthedata objectAtIndex:i]floatValue] < MinValue){
            MinValue = [[Allthedata objectAtIndex:i]floatValue];
        }
    }

    self.LineChart.minimumValue = (MinValue*0.975);
    self.LineChart.maximumValue = (MaxValue);
    
    self.LineChart.headerPadding = 70;
    self.LineChart.footerPadding = 50;
    
    [self.LineChart reloadDataAnimated:YES];
    
}

@end
