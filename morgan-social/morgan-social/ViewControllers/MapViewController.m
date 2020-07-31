//
//  MapViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/23/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "MapViewController.h"
@import GoogleMaps;
@import GooglePlaces;
@interface MapViewController ()
@property (strong, nonatomic) IBOutlet UIView *map;

@end

@implementation MapViewController {
    GMSPlacesClient *_placesClient;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _placesClient = [GMSPlacesClient sharedClient];
    // Do any additional setup after loading the view.
    CGRect currentFrame = self.map.frame;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:39.3438 longitude:-76.5844 zoom:18];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(0, 100, currentFrame.size.width, currentFrame.size.height) camera:camera];
    mapView.mapType = kGMSTypeHybrid;
    mapView.myLocationEnabled = YES;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(39.3438, -76.5844);
    marker.title = @"Morgan";
    marker.snippet = @"University";
    marker.map = mapView;
    self.map = mapView;
    [self.view addSubview:self.map];
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
