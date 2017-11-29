//
//  ActivityGraphViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "ActivityGraphViewController.h"

@interface ActivityGraphViewController ()

@property (weak, nonatomic) NSArray *ChartData;
@property (weak, nonatomic) NSArray *ChartLabels;

@property (strong, nonatomic) NSArray *WeekData;
@property (strong, nonatomic) NSArray *MonthData;
@property (strong, nonatomic) NSArray *DaysInAWeek;
@property (strong, nonatomic) NSArray *WeeksInAMonth;

@end

@implementation ActivityGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.WeekData = [NSArray arrayWithObjects:
                            @20,@30,@40,@35,@25,@45,@30, nil];
    self.MonthData = [NSArray arrayWithObjects:
                            @500,@600,@550,@400,@475, nil];
    
    self.DaysInAWeek = [NSArray arrayWithObjects:
                        @"Monday",@"Sunday", nil];
    
    self.WeeksInAMonth = [NSArray arrayWithObjects:
                        @"Week1",@"Week5", nil];

    
    [self UpdateData];
    
    [self.ActivityBarChart reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.ActivityBarChart setState:JBChartViewStateExpanded];
    [self.ActivityBarChart reloadDataAnimated:animated];
    
}


-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView {
    
    return [self.ChartData count];
    
}

-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index {
    
    return [[self.ChartData objectAtIndex:index]floatValue];
    
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
    
    self.BarValueLabel.text = [NSString stringWithFormat:@"%.1f Calories",[[self.ChartData objectAtIndex:index]floatValue]];
    
}

-(void)didDeselectBarChartView:(JBBarChartView *)barChartView {
    
    self.BarValueLabel.text = [NSString stringWithFormat:@" "];
    
}

- (IBAction)SegmentedControlChanged:(id)sender {

    if (self.BarChartType.selectedSegmentIndex == 0){
        
        self.ChartData = self.WeekData;
        self.ChartLabels = self.DaysInAWeek;
        
    } else if (self.BarChartType.selectedSegmentIndex ==1){
        
        self.ChartData = self.MonthData;
        self.ChartLabels = self.WeeksInAMonth;
        
    } else {
        
    }
    
    [self UpdateData];
    [self.ActivityBarChart reloadData];
    
}

-(void) UpdateData {
    
    self.ActivityBarChart.delegate = self;
    self.ActivityBarChart.dataSource = self;
    
    self.ActivityBarChart.minimumValue = 0.0f;
    self.ActivityBarChart.headerPadding = 40.0f;
    self.ActivityBarChart.footerPadding = 0.0f;
    self.ActivityBarChart.backgroundColor = [UIColor lightGrayColor];
    self.ActivityBarChart.inverted = NO;
    
    self.LeftFooterLabel.text = [NSString stringWithFormat:@"%@",[self.ChartLabels objectAtIndex:0]];
    self.RightFooterLabel.text = [NSString stringWithFormat:@"%@",[self.ChartLabels objectAtIndex:1]];
    
}

@end
