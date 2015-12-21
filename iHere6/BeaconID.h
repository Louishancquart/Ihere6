//
//  BeaconID.h
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#ifndef BeaconID_h
#define BeaconID_h


#endif /* BeaconID_h */

#import <Foundation/Foundation.h>
#import <EstimoteSDK.Estimote.h>

@interface BeaconID : NSObject <NSCopying>

@property (nonatomic, readonly) NSUUID *proximityUUID;
@property (nonatomic, readonly) CLBeaconMajorValue major;
@property (nonatomic, readonly) CLBeaconMinorValue minor;

@property (nonatomic, readonly) NSString *asString;
@property (nonatomic, readonly) CLBeaconRegion *asBeaconRegion;

- (instancetype)initWithProximityUUID:(NSUUID *)proximityUUID major:(CLBeaconMajorValue)major minor:(CLBeaconMinorValue)minor ;
- (instancetype)initWithUUIDString:(NSString *)UUIDString major:(CLBeaconMajorValue)major minor:(CLBeaconMinorValue)minor;

- (BOOL)isEqualToBeaconID:(BeaconID *)beaconID;

@end

@interface CLBeacon (BeaconID)

@property (nonatomic, readonly) BeaconID *beaconID;

@end