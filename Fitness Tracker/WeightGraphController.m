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
    
    NSDate *CurrentData;
    
    
}
@end

@implementation WeightGraphController

- (void)viewDidLoad {

    
    WeekData = [NSArray arrayWithObjects:
                    @80,@82,@85,@80,@81,@79,@78,@82, nil];
    
    PreviousWeekData = [NSArray arrayWithObjects:
                @90,@87,@85,@82,@83,@79,@81,@82, nil];
    
    ChartData = WeekData;
    [self UpdateData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.LineChart setState:JBChartViewStateExpanded];
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
        return [UIColor greenColor];
    } if (lineIndex == 1){
        return [UIColor blueColor];
    }
    return 0;                                                                       //Set the color of the lines
}


-(UIColor *)lineChartView:(JBLineChartView *)lineChartView fillColorForLineAtLineIndex:(NSUInteger)lineIndex {
    return [UIColor colorWithWhite:0.75 alpha:0.6];                                 //Set the fill color that appears under the line
}

-(BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex {
    return false;                                                                   //True - The lines will be smooth. False - the lines will be straight.
}

#pragma Actions for when a data set is clicked on
-(void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex {
}

-(void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView {
}


#pragma Changing the looks of the data dots
-(BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex {
    return true;
}

-(UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return [UIColor darkGrayColor];                                                 //Set the color of the dots
}
-(CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return 5.0;                                                                     //Set the radius of the dots
}




- (IBAction)RefreshButtonPressed:(id)sender {
    
    [self UpdateData];
    [self.LineChart reloadDataAnimated:YES];
    
}

-(void) UpdateData {
    
    self.LineChart.delegate = self;
    self.LineChart.dataSource = self;
    
    //Setting the min and max values of the graph by using the min and max from the data
    float MaxValue = 0.0;
    float MinValue = 10000.0;
    
    for(int i = 0 ; i < ([ChartData count]) ; i++){
        if([[ChartData objectAtIndex:i] floatValue] > MaxValue){
            MaxValue = [[ChartData objectAtIndex:i]floatValue];
        }else if([[ChartData objectAtIndex:i]floatValue] < MinValue){
            MinValue = [[ChartData objectAtIndex:i]floatValue];
        }
    }

    self.LineChart.minimumValue = (MinValue*0.8);
    self.LineChart.maximumValue = (MaxValue*1.15);
    
    [self.LineChart reloadDataAnimated:YES];
    
}

@end
