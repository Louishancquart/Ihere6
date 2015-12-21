//
//  BeaconDistance.h
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#ifndef BeaconDistance_h
#define BeaconDistance_h


#endif /* BeaconDistance_h */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BeaconDistance : NSObject

@property (assign, nonatomic) CGFloat distance;
@property (assign, nonatomic) CGPoint beaconCoordinates;

+ (BeaconDistance *)beaconWithDistance:(double)distance coordinates:(CGPoint)beaconCoordinates;

@end
