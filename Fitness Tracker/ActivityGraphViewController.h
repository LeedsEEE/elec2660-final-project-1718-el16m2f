//
//  ActivityGraphViewController.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 21/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JBChart/JBChart.h>

@interface ActivityGraphViewController : UIViewController <JBBarChartViewDelegate , JBBarChartViewDataSource>

@property (weak, nonatomic) IBOutlet JBBarChartView *ActivityBarChart;


@end
