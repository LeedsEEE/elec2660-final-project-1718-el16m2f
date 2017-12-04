//
//  WeightGraphController.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 28/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JBChart/JBChart.h>

@interface WeightGraphController : UIViewController <JBLineChartViewDelegate , JBLineChartViewDataSource>

@property (weak, nonatomic) IBOutlet JBLineChartView *LineChart;

- (IBAction)RefreshButtonPressed:(id)sender;

@end
