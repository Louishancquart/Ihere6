//
//  PositioningViewController.h
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trilateration.h"

@interface PositioningViewController : UIViewController <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    CLBeaconRegion *beaconRegion;
    CLLocationManager *locationManager;
    
    NSDictionary *beaconCoordinates;
    float scaleFactor;
    int maxY;
    
   Trilateration *beaconTrilaterator;
    
    NSMutableArray *foundBeacons;
    
    // User Interface
    IBOutlet UILabel *xyResult;
    IBOutlet UITableView *beaconsTableView;
    //IBOutlet UILabel *beaconsFound;
    IBOutlet UILabel *selfView;
    IBOutlet UIView *beaconGrid;
    IBOutlet UILabel *beaconsFound;
}


@end
