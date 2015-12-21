//
//  BeaconDistance.m
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeaconDistance.h"

@implementation BeaconDistance

+ (BeaconDistance *)beaconWithDistance:(double)distance coordinates:(CGPoint)beaconCoordinates
{
    BeaconDistance *beaconDistance = [BeaconDistance new];
    beaconDistance.distance = distance;
    beaconDistance.beaconCoordinates = beaconCoordinates;
    return beaconDistance;
}

@end