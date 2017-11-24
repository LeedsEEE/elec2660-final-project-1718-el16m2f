//
//  FacilityLocator.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 20/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "FacilityLocator.h"

@interface FacilityLocator ()
{
    
    NSArray *Gyms;
}

@end

@implementation FacilityLocator

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Radius = 5;
    ConversionToLongAndLat = 111.32;                    //The zooming funcitons use longitude and latitude, this variable is a converting constant.
    
    self.RadiusLabel.text = [NSString stringWithFormat:@"%.1f Km", Radius];
    _Slider.value = Radius;
    
    self.Location = [[CLLocationManager alloc]init];
    
    self.Map.delegate = self;
    self.Location.delegate = self;
    
    [self.Location requestWhenInUseAuthorization];      //Sends out a request to use the user's location
    
    self.Map.showsUserLocation = YES;                   //Tells the map to show the user's location
    
    CLLocation *CurrentLocation = self.Location.location;
    CurrentLocationCoords = CurrentLocation.coordinate;
    
    self.Map.region = MKCoordinateRegionMake(CurrentLocationCoords, MKCoordinateSpanMake((Radius+0.5)/ConversionToLongAndLat, (Radius+0.5)/ConversionToLongAndLat)); //Zooming the map into current location spanning to delta longitude and delta latitude
    
}

- (IBAction)SearchButtonPressed:(id)sender {
    
    self.Map.region = MKCoordinateRegionMake(CurrentLocationCoords, MKCoordinateSpanMake((Radius+0.5)/ConversionToLongAndLat, (Radius+0.5)/ConversionToLongAndLat)); //Zooming the map into current location spanning to delta longitude and delta latitude
    
    [self QueryGooglePlaces];
    
    //MKMapPoint *annotation = [[MKmappoint alloc]init];
    
    for (int a=0; a < [Gyms count]; a++) {                                          //Places a point for each type of building found in the search.
        
        CLLocationCoordinate2D Coordinates2D;
        
#pragma Using the data retreived from the query.
        
        NSDictionary *Loc = [Gyms objectAtIndex:a];
        NSDictionary *geometry = [Loc objectForKey:@"geometry"];
        NSDictionary *Place = [geometry objectForKey:@"location"];                  //This collection looks through the Gym array to find the values required for Longitude and Latitude
        
        Coordinates2D.latitude = [[Place objectForKey:@"lat"] floatValue];
        Coordinates2D.longitude = [[Place objectForKey:@"lng"] floatValue];         //Sets the latitude and longitude of to an object called coordinates by looking at the JSON data.
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        
        annotation.title = [NSString stringWithFormat:@"%@",[Loc objectForKey:@"name"]];
        annotation.coordinate = Coordinates2D;
        annotation.subtitle = [NSString stringWithFormat:@"%@",[Loc objectForKey:@"vicinity"]];     //Creates titles and subtitles for the annotated point.
        
        [self.Map addAnnotation:annotation];
        
    }
    
}


#pragma Slider moved action
- (IBAction)RadiusSliderMoved:(UISlider *)sender {
    
    Radius = sender.value;                                                                  //Sets the variable 'Radius' to the value of the slider.
    self.RadiusLabel.text = [NSString stringWithFormat:@"%.1f Km", sender.value];           //Changes the label to the value of the label.
    
}


#pragma Creating a query for Google to find POIs
- (void) QueryGooglePlaces {
    
    NSInteger SearchRadius = (int)Radius*1000;
    
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%.6f,%.6f&radius=%li&type=gym&key=%@",CurrentLocationCoords.latitude,CurrentLocationCoords.longitude,SearchRadius,GOOGLE_MAPS_API_KEY];
    
    //Turn the string above into a URL format which is required to send the request
    NSURL *GoogleRequestURL = [NSURL URLWithString:URL];
    
    //Retreiving the results
    dispatch_async(GoogleKeyQueue, ^ {NSData *Data = [NSData dataWithContentsOfURL:GoogleRequestURL];
        [self performSelectorOnMainThread:@selector(FetchedData:)  withObject:Data waitUntilDone:YES];
                });
    
}
 

-(void)FetchedData: (NSData *)responseData {
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    //Results retrieved from Google will be placed into an array
    Gyms = [json objectForKey:@"results"];                     //When the JSON file comes back the data is stored in keys which they've labelled 'results', We convert this to an array to then use.
    
    
}

@end
