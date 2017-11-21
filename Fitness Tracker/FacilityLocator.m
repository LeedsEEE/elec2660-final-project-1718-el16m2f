//
//  FacilityLocator.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 20/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "FacilityLocator.h"

@interface FacilityLocator ()

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SearchButtonPressed:(id)sender {
    
    self.Map.region = MKCoordinateRegionMake(CurrentLocationCoords, MKCoordinateSpanMake((Radius+0.5)/ConversionToLongAndLat, (Radius+0.5)/ConversionToLongAndLat)); //Zooming the map into current location spanning to delta longitude and delta latitude
    
    [self QueryGooglePlaces];
    
}

- (IBAction)RadiusSliderMoved:(UISlider *)sender {
    
    Radius = sender.value;                                                                  //Sets the variable 'Radius' to the value of the slider.
    self.RadiusLabel.text = [NSString stringWithFormat:@"%.1f Km", sender.value];           //Changes the label to the value of the label.
    
}


#pragma Creating a query for Google to find POIs
- (void) QueryGooglePlaces {
    
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=gym&sensor=true&key=%@", CurrentLocationCoords.latitude, CurrentLocationCoords.longitude,[NSString stringWithFormat:@"%f", Radius/ConversionToLongAndLat], GOOGLE_MAPS_API_KEY];
    
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
    
    //Results retrieved from Google will be placed into an array.
    NSArray* Gyms = [json objectForKey:@"Results"];
    
    //Printing the data to the console
    NSLog(@"Gym Data - %@", Gyms);
}

@end
