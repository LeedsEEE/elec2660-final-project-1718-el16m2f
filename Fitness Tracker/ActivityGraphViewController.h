//
//  ActivityGraphViewController.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JBChart/JBChart.h>
#import "DataMethods.h"

@interface ActivityGraphViewController : UIViewController <JBBarChartViewDelegate , JBBarChartViewDataSource>

@property (weak, nonatomic) IBOutlet JBBarChartView *ActivityBarChart;
@property (weak, nonatomic) IBOutlet UILabel *BarValueLabel;

- (IBAction)SegmentedControlChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *BarChartType;

@property (weak, nonatomic) IBOutlet UILabel *LeftFooterLabel;
@property (weak, nonatomic) IBOutlet UILabel *RightFooterLabel;

@end
