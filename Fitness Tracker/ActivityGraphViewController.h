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
{
    NSArray *ChartData;
    NSArray *ChartLabels;
    
    NSArray *WeekData;
    NSArray *MonthData;
    NSArray *YearData;
    
    NSDate *CurrentDate;
    
    NSDateFormatter *WordedDayFormat;
    NSDateFormatter *WordedMonthFormat;
}

@property (weak, nonatomic) IBOutlet JBBarChartView *ActivityBarChart;
@property (weak, nonatomic) IBOutlet UILabel *BarValueLabel;

- (IBAction)SegmentedControlChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *BarChartType;

@property (weak, nonatomic) IBOutlet UILabel *LeftFooterLabel;
@property (weak, nonatomic) IBOutlet UILabel *RightFooterLabel;

@end

/*
// To create the Bar Chart the Jawbone Chart framework was used as this allowed the ease of making a stunning chart 
//JBJawbone charts: https://github.com/Jawbone/JBChartView 
//How to display bar graphs: https://www.youtube.com/watch?v=2J-_YBXEhNU&t=2185s
//How to display line graphs: https://www.youtube.com/watch?v=hMdMg3mcSCc
*/
