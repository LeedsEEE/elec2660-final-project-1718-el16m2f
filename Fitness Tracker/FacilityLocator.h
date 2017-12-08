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

//An API key that is defined as it never changes.
//Reference:
//https://developers.google.com/places/web-service/get-api-key
#define GOOGLE_MAPS_API_KEY @"AIzaSyDQ6CsrOQXiKQUiqe5k77ap5n8J-D2aXkU"

#define GoogleKeyQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface FacilityLocator : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CGFloat Radius;
    CGFloat ConversionToLongAndLat;
    CLLocationCoordinate2D CurrentLocationCoords;
    
    NSArray *Gyms;
}

@property (weak, nonatomic) IBOutlet MKMapView *Map;
@property (strong, nonatomic) CLLocationManager *Location;

@property (weak, nonatomic) IBOutlet UISegmentedControl *MapTypeController;
- (IBAction)MapTypeSelected:(id)sender;

- (IBAction)RadiusSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *RadiusSegmentController;

@end

/*
//For the Map tab the following references were used.
//Using Google Places API: https://www.raywenderlich.com/13160/using-the-google-places-api-with-mapkit/Google 
//Places Web service API key: https://developers.google.com/places/web-service/get-api-key
//Apple Developer Video: https://developer.apple.com/videos/play/wwdc2017/237/
*/
