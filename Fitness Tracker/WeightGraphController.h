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
{
    NSArray *ChartLabels;
    
    NSArray *WeekData;
    NSArray *PreviousWeekData;
    
    NSDate *CurrentDate;
    NSDateFormatter *WordedDayFormat;
    
}

@property (weak, nonatomic) IBOutlet JBLineChartView *LineChart;

@property (weak, nonatomic) IBOutlet UILabel *TypeOfWeek;

@property (weak, nonatomic) IBOutlet UILabel *LeftChartFooter;
@property (weak, nonatomic) IBOutlet UILabel *RightChartFooter;

@property (weak, nonatomic) IBOutlet UILabel *ChartValue;

/*
 // To create the Bar Chart the Jawbone Chart framework was used as this allowed the ease of making a stunning chart
 //JBJawbone charts: https://github.com/Jawbone/JBChartView
 //How to display bar graphs: https://www.youtube.com/watch?v=2J-_YBXEhNU&t=2185s
 //How to display line graphs: https://www.youtube.com/watch?v=hMdMg3mcSCc
 //
 //
 //To add in test data there is a few comments laying around like so [COREDATA] / [FAKEDATA]
 //For test data to load with no core data un-comment the lines with [FAKEDATA] in it and add comments to the begining of the lines with [COREDATA] and vice versa
 */

@end
