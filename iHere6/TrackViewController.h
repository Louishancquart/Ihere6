//
//  TrackViewController.h
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TrackViewController : UITableViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *beaconFound1Label;
@property (weak, nonatomic) IBOutlet UILabel *beaconFound2Label;
@property (weak, nonatomic) IBOutlet UILabel *beaconFound3Label;

@property (weak, nonatomic) IBOutlet UILabel *proximityUUID1Label;
@property (weak, nonatomic) IBOutlet UILabel *proximityUUID2Label;
@property (weak, nonatomic) IBOutlet UILabel *proximityUUID3Label;

@property (weak, nonatomic) IBOutlet UILabel *major1Label;
@property (weak, nonatomic) IBOutlet UILabel *major2Label;
@property (weak, nonatomic) IBOutlet UILabel *major3Label;

@property (weak, nonatomic) IBOutlet UILabel *minor1Label;
@property (weak, nonatomic) IBOutlet UILabel *minor2Label;
@property (weak, nonatomic) IBOutlet UILabel *minor3Label;

@property (weak, nonatomic) IBOutlet UILabel *accuracy1Label;
@property (weak, nonatomic) IBOutlet UILabel *accuracy2Label;
@property (weak, nonatomic) IBOutlet UILabel *accuracy3Label;

@property (weak, nonatomic) IBOutlet UILabel *distance1Label;
@property (weak, nonatomic) IBOutlet UILabel *distance2Label;
@property (weak, nonatomic) IBOutlet UILabel *distance3Label;

@property (weak, nonatomic) IBOutlet UILabel *rssi1Label;
@property (weak, nonatomic) IBOutlet UILabel *rssi2Label;
@property (weak, nonatomic) IBOutlet UILabel *rssi3Label;


@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end
