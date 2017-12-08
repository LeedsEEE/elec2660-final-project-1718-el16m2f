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

    //Creates a font so that the text inside the segment controllers can be larger
    //Reference:
    //https://stackoverflow.com/questions/2280391/change-font-size-of-uisegmentedcontrol
    UIFont *CustomFont = [UIFont systemFontOfSize:22.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:CustomFont forKey:NSFontAttributeName];
    [self.MapTypeController setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.RadiusSegmentController setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    Radius = 2;                                             //Sets the initial search radius to 2Km
    ConversionToLongAndLat = 111.32;                        //The zooming funcitons use longitude and latitude, this variable is a converting constant.
    
    self.Location = [[CLLocationManager alloc]init];
    self.Location.delegate = self;
    [self.Location requestWhenInUseAuthorization];          //Sends out a request to use the user's location by displaying an alert on the phone
    
    self.Map.delegate = self;
    self.Map.showsUserLocation = YES;                       //Tells the map to show the user's location
    
    CLLocation *CurrentLocation = self.Location.location;
    CurrentLocationCoords = CurrentLocation.coordinate;     //Sets the CLLocation currentlocation to the users loaction via the gps
    
}

-(void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    //This function is called when the map is fully loaded. Once the map has fully loaded the it updates the annotations. This also applies to when the map is being zoomed in and out.
    
    [self UpdateSearches];
}

-(BOOL)prefersStatusBarHidden {
    return YES;                                                 //This function removes the status bar, as it was getting in the way.
}


#pragma mark Changing the map type with a segment controller

- (IBAction)MapTypeSelected:(id)sender {
    
    if(self.MapTypeController.selectedSegmentIndex == 0){               //If the segmented control is changed the map type will change to reflect the value selected
        self.Map.mapType = MKMapTypeStandard;
    } else if (self.MapTypeController.selectedSegmentIndex == 1){
        self.Map.mapType = MKMapTypeSatellite;
    } else if (self.MapTypeController.selectedSegmentIndex == 2){
        self.Map.mapType = MKMapTypeHybrid;
    }
    
}


#pragma mark Changing the searching radius

- (IBAction)RadiusSelected:(id)sender {                                 //If the radius segmented control is changed the search radius will be updated to reflect the value selected
    
    if (self.RadiusSegmentController.selectedSegmentIndex == 0){
        Radius = 2;
    } else if(self.RadiusSegmentController.selectedSegmentIndex == 1){
        Radius = 5;
    } else if(self.RadiusSegmentController.selectedSegmentIndex == 2){
        Radius = 10;
    }
    
    [self UpdateSearches];                                              //After selecting a searching radius the map is then updated
    
}

#pragma mark Function for doing searches

- (void) UpdateSearches {
    
    //This methods should be used when the graph need to be updated.
    
    [self.Map removeAnnotations:self.Map.annotations];                              //Removes all the previously loaded annotations.
    
    CLLocation *CurrentLocation = self.Location.location;
    CurrentLocationCoords = CurrentLocation.coordinate;                             //Re-calculating the users position.
    
    self.Map.region = MKCoordinateRegionMake(CurrentLocationCoords, MKCoordinateSpanMake( (Radius+0.5)/ConversionToLongAndLat, (Radius+0.5)/ConversionToLongAndLat ));      //Zooming the map into current location spanning to delta longitude and delta latitude
    
    [self QueryGooglePlaces];                                                       //Sends a https request to google
    [self AddArrayOfCoordinates:Gyms];                                              //Adds the retreived data as annotations
    
}

-(void)AddArrayOfCoordinates:(NSArray *)JSONArray{
 
    for (int a=0; a < [JSONArray count]; a++) {                                                     //Places a point for each type of piece of data found in the search.
        
        CLLocationCoordinate2D Coordinates2D;
        
        //Below Here the app sorts through the recieved array and plots annotations
        
        NSDictionary *Loc = [JSONArray objectAtIndex:a];
        NSDictionary *geometry = [Loc objectForKey:@"geometry"];
        NSDictionary *Place = [geometry objectForKey:@"location"];                                  //This collection looks through the Gym array to find the values required for Longitude and Latitude. The NSDictionary must 
        
        Coordinates2D.latitude = [[Place objectForKey:@"lat"] floatValue];
        Coordinates2D.longitude = [[Place objectForKey:@"lng"] floatValue];                         //Sets the latitude and longitude of to an object called coordinates by looking at the JSON data.
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        
        annotation.coordinate = Coordinates2D;
        annotation.title = [NSString stringWithFormat:@"%@",[Loc objectForKey:@"name"]];
        annotation.subtitle = [NSString stringWithFormat:@"%@",[Loc objectForKey:@"vicinity"]];     //Creates titles and subtitles for the annotated point.
        
        [self.Map addAnnotation:annotation];
    }
}


#pragma mark Creating a query for Google to find POIs using HTTPS

//To query google about the local area a request is prepared.
//Reference:
//https://www.raywenderlich.com/13160/using-the-google-places-api-with-mapkit/Google
- (void) QueryGooglePlaces {
    
    NSInteger SearchRadius = (int)Radius*1000;
    
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%.6f,%.6f&radius=%li&type=gym&key=%@",CurrentLocationCoords.latitude,CurrentLocationCoords.longitude,SearchRadius,GOOGLE_MAPS_API_KEY];                                                                 //The URL search takes an input of Latitude then Longitude, a search radius then you can specifiy the type of POI you want to search for <https://developers.google.com/places/supported_types> then the API key aquired from Google.
    
    NSURL *GoogleRequestURL = [NSURL URLWithString:URL];                                      //When the string has been made it is converted into URL format so that it can be queried
    
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
    Gyms = [json objectForKey:@"results"];                     //When the JSON file comes back the data is stored in keys which they've labelled 'results', We convert this to an array to then use.
}

@end
