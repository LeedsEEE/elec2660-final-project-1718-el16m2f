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
    
    NSDate *CurrentData;
    
    
}
@end

@implementation WeightGraphController

- (void)viewDidLoad {

    
    WeekData = [NSArray arrayWithObjects:
                    @80,@82,@85,@80,@78,@82, nil];
    
    
    self.LineChart.delegate = self;
    self.LineChart.dataSource = self;
    
    self.LineChart.minimumValue = 0;
    self.LineChart.backgroundColor = [UIColor lightGrayColor];
    
    [self.LineChart reloadDataAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.LineChart setState:JBChartViewStateExpanded];
}


#pragma Line Chart Data source
-(NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    
    return 1;
}

-(NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
    
    return 1;
}

-(CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    
    return [[WeekData objectAtIndex:horizontalIndex] floatValue];
    
}

#pragma Line Chart Delegate

-(UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    
    return [UIColor redColor];
}

-(UIColor *)lineChartView:(JBLineChartView *)lineChartView fillColorForLineAtLineIndex:(NSUInteger)lineIndex {
    
    return [UIColor redColor];
}



@end
