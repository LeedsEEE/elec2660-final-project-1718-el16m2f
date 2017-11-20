//
//  FacilityLocator.h
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 20/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//
//  Reference: https://www.raywenderlich.com/13160/using-the-google-places-api-with-mapkit

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define GOOGLE_MAPS_API_KEY @"AIzaSyBH6CpYrt1EiwK9nsBHBZAmjz9Ptunu9Xs"

@interface FacilityLocator : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CGFloat Radius;
    CGFloat ConversionToLongAndLat;
    CLLocationCoordinate2D CurrentLocationCoords;
}

@property (weak, nonatomic) IBOutlet MKMapView *Map;
@property (strong, nonatomic) CLLocationManager *Location;
@property (weak, nonatomic) IBOutlet UISlider *Slider;

@property (weak, nonatomic) IBOutlet UILabel *RadiusLabel;

- (IBAction)SearchButtonPressed:(id)sender;
- (IBAction)RadiusSliderMoved:(UISlider *)sender;


@end
