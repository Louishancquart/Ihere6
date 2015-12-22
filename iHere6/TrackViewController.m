//
//  TrackViewController.m
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#import "TrackViewController.h"


@implementation TrackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    

    if ([self deviceSettingsAreCorrect])
    {
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)initRegion {
    NSUUID *uuid1 = [[NSUUID alloc] initWithUUIDString:@":C1:90:8E:4B:16:E5"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid1 identifier:@"Beacons"];
    
    
    
     NSUUID *uuid2 = [[NSUUID alloc] initWithUUIDString:@":C1:90:8E:4B:16:E5"];
     self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid2 identifier:@"Beacons"];
     
     NSUUID *uuid3 = [[NSUUID alloc] initWithUUIDString:@":C1:90:8E:4B:16:E5"];
     self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid3 identifier:@"Beacons"];
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    self.beaconFound1Label.text = @"No";
    self.beaconFound2Label.text = @"No";
    self.beaconFound3Label.text = @"No";


}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    self.beaconFound1Label.text = @"Yes";
    self.beaconFound2Label.text = @"Yes";
    self.beaconFound3Label.text = @"Yes";
    
    self.proximityUUID1Label.text = beacon.proximityUUID.UUIDString;
    self.proximityUUID2Label.text = beacon.proximityUUID.UUIDString;
    self.proximityUUID3Label.text = beacon.proximityUUID.UUIDString;

    self.major1Label.text = [NSString stringWithFormat:@"%@", beacon.major];
    self.major2Label.text = [NSString stringWithFormat:@"%@", beacon.major];
    self.major3Label.text = [NSString stringWithFormat:@"%@", beacon.major];
    
    self.minor1Label.text = [NSString stringWithFormat:@"%@", beacon.minor];
    self.minor2Label.text = [NSString stringWithFormat:@"%@", beacon.minor];
    self.minor3Label.text = [NSString stringWithFormat:@"%@", beacon.minor];
    
    self.accuracy1Label.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    if (beacon.proximity == CLProximityUnknown) {
        self.distance1Label.text = @"Unknown Proximity";
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distance1Label.text = @"Immediate";
    } else if (beacon.proximity == CLProximityNear) {
        self.distance1Label.text = @"Near";
    } else if (beacon.proximity == CLProximityFar) {
        self.distance1Label.text = @"Far";
    }
    self.accuracy2Label.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    if (beacon.proximity == CLProximityUnknown) {
        self.distance2Label.text = @"Unknown Proximity";
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distance2Label.text = @"Immediate";
    } else if (beacon.proximity == CLProximityNear) {
        self.distance2Label.text = @"Near";
    } else if (beacon.proximity == CLProximityFar) {
        self.distance2Label.text = @"Far";
    }
    self.accuracy3Label.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    if (beacon.proximity == CLProximityUnknown) {
        self.distance3Label.text = @"Unknown Proximity";
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distance3Label.text = @"Immediate";
    } else if (beacon.proximity == CLProximityNear) {
        self.distance3Label.text = @"Near";
    } else if (beacon.proximity == CLProximityFar) {
        self.distance3Label.text = @"Far";
    }
    self.rssi1Label.text = [NSString stringWithFormat:@"rssi1 : %li", (long)beacon.rssi];
    self.rssi2Label.text = [NSString stringWithFormat:@"rssi2 : %li", (long)beacon.rssi];
    self.rssi3Label.text = [NSString stringWithFormat:@"rssi3 : %li", (long)beacon.rssi];
    

}


- (void) showErrorWithMessage: (NSString *) message
{
    [[[UIAlertView alloc] initWithTitle: message
                                message: nil
                               delegate: nil
                      cancelButtonTitle: @"Ok"
                      otherButtonTitles: nil] show];
}


- (BOOL) deviceSettingsAreCorrect
{
    NSString *errorMessage = @"";
    
    if (![CLLocationManager locationServicesEnabled]
        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        errorMessage = [errorMessage stringByAppendingString: @"Location services are turned off! Please turn them on!\n"];
    }
    
    if (![CLLocationManager isRangingAvailable])
    {
        errorMessage = [errorMessage stringByAppendingString: @"Ranging not available!\n"];
    }
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]])
    {
        errorMessage = [errorMessage stringByAppendingString: @"Beacons ranging not supported!\n"];
    }
    
    if ([errorMessage length])
    {
        [self showErrorWithMessage: errorMessage];
    }
    
    return [errorMessage length] == 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
