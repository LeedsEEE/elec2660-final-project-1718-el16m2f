//
//  ActivityGraphViewController.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "ActivityGraphViewController.h"

@interface ActivityGraphViewController ()

@end

@implementation ActivityGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ActivityBarChart.delegate = self;
    self.ActivityBarChart.dataSource = self;
    
    self.ActivityBarChart.minimumValue = 0.0f;
    self.ActivityBarChart.maximumValue = 60.0f;
    self.ActivityBarChart.headerPadding = 20.0f;
    self.ActivityBarChart.backgroundColor = [UIColor lightGrayColor];
    
    [self.ActivityBarChart reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.ActivityBarChart setState:JBChartViewStateExpanded];
    
}


-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView {
    
    return 10;
    
}

-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index {
    
    NSArray *TestData = [NSArray arrayWithObjects:
                         @20,@30,@40,@35,@25,@45,@25,@10,@35,@30,nil];
    
    return [[TestData objectAtIndex:index]floatValue];
    
}

-(UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView {
    
    return [UIColor whiteColor];
    
}

-(UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index {
    
    return [UIColor orangeColor];
    
}

@end
