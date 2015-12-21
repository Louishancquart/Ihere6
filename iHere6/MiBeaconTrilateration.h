//
//  ViewController.h
//  iHere6
//
//  Created by Shiva on 12/15/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface MiBeaconTrilateration : NSObject

- (void)trilaterateWithBeacons:(NSArray *)beacons done:(void (^)(NSString *error, NSArray *coordinates))doneBlock;

@end
