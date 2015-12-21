//
//  BeaconNotificationsManager.h
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#ifndef BeaconNotificationsManager_h
#define BeaconNotificationsManager_h


#endif /* BeaconNotificationsManager_h */

#import <Foundation/Foundation.h>
#import "BeaconID.h"

@interface BeaconNotificationsManager : NSObject

- (void)enableNotificationsForBeaconID:(BeaconID *)beaconID
                          enterMessage:(NSString *)enterMessage
                           exitMessage:(NSString *)exitMessage;

@end