//
//  PositioningViewController.m
//  iHere6
//
//  Created by Shiva on 12/21/15.
//  Copyright © 2015 Shiva. All rights reserved.
//

#import "PositioningViewController.h"



@interface UIViewController ()



@end

@implementation PositioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    
    // Estimote beacon UUID
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];     // why this one and not beacons uuids?
    beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"Trilateration"]; // why this one and not Beacons?
    
    // start ranging ID
    [locationManager startRangingBeaconsInRegion:beaconRegion];
    
    beaconTrilaterator = [[Trilateration alloc] init];
    
    // misc UI settings
    [beaconGrid.layer setCornerRadius:10];
    [selfView.layer setCornerRadius:10];
    
    [self plotBeaconsFromPlistToGrid];
    
    
    db = [FMDatabase databaseWithPath:@"./data.db"];
    
    if (![db open]) { // test if db cannot oppen
        NSLog(@" error connecteing DB");
        return;
    }
    
    //call db TEST
    NSString *sql = @"create table bulktest1 (id integer primary key autoincrement, x text);"
    "create table bulktest2 (id integer primary key autoincrement, y text);"
    "create table bulktest3 (id integer primary key autoincrement, z text);"
    "insert into bulktest1 (x) values ('XXX');"
    "insert into bulktest2 (y) values ('YYY');"
    "insert into bulktest3 (z) values ('ZZZ');";
    
    BOOL success = [db executeStatements:sql];
    
    sql = @"select count(*) as count from bulktest1;"
    "select count(*) as count from bulktest2;"
    "select count(*) as count from bulktest3;";
    
    success = [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
       // NSInteger count = [dictionary[@"count"] integerValue];
       // XCTAssertEqual(count, 1, @"expected one record for dictionary %@", dictionary);
        return 0;
    }];
    
    
    [db close]; // close DB !!!!

    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plotBeaconsFromPlistToGrid {
    // load plist to dictionary
    if (!beaconCoordinates)
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"beaconCoordinates" ofType:@"plist"];
        beaconCoordinates = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    
    // determine max coordinate to calculate scalefactor
    float maxCoordinate = -MAXFLOAT;
    float minCoordinate = MAXFLOAT;
    
    for (NSString* key in beaconCoordinates) {
        NSArray *coordinates = [beaconCoordinates objectForKey:key];
        int X = [[coordinates objectAtIndex:0] intValue];
        int Y = [[coordinates objectAtIndex:1] intValue];
        
        // max & min y & x
        if (X < minCoordinate) minCoordinate = X;
        if (X > maxCoordinate) maxCoordinate = X;
        if (Y < minCoordinate) minCoordinate = Y;
        if (Y > maxCoordinate) maxCoordinate = Y;
    }
    
    scaleFactor = 290 / (maxCoordinate-minCoordinate); //290 is width/height gridView
    maxY = (maxCoordinate-minCoordinate) * scaleFactor;
    
    // loop through dictionary to plot all beacons
    for (NSString* key in beaconCoordinates) {
        NSArray *coordinates = [beaconCoordinates objectForKey:key];
        int X = [[coordinates objectAtIndex:0] intValue];
        int Y = [[coordinates objectAtIndex:1] intValue];
        
        UILabel *beaconLabel = [[UILabel alloc] initWithFrame:CGRectMake((X * scaleFactor)-10, (maxY-(Y * scaleFactor))-10, 20, 20)];
        [beaconLabel setText:key];
        
        [beaconLabel setBackgroundColor:[UIColor colorWithRed:(10/255.0) green:(140/255.0) blue:(220/255.0) alpha:1]];
        [beaconLabel setTextAlignment:NSTextAlignmentCenter];
        [beaconLabel setFont:[UIFont fontWithName:@"Helvetica-Neue Light" size:15.0f]];
        [beaconLabel setTextColor:[UIColor whiteColor]];
        [beaconLabel.layer setCornerRadius:10.0f];
        
        [beaconGrid addSubview:beaconLabel];
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    foundBeacons = [beacons copy];
    
    // put them in the tableView
    [beaconsFound setText:[NSString stringWithFormat:@"Found beacons (%lu)", (unsigned long)[foundBeacons count]]];  // why this was commented ?
    [beaconsTableView reloadData];                                                                                     // why this was commented ?  I fixed this
    
    // perform trilateration
    [beaconTrilaterator trilaterateWithBeacons:foundBeacons done:^(NSString *error, NSArray *coordinates) {
        if ([error isEqualToString:@""])
        {
            float x = [[coordinates objectAtIndex:0] floatValue];
            float y = [[coordinates objectAtIndex:1] floatValue];
            
            [xyResult setText:[NSString stringWithFormat:@"X: %.1f   Y: %.1f", x, y]];
            [selfView setHidden:NO];
            [selfView setFrame:CGRectMake((x * scaleFactor)-10, (maxY-(y * scaleFactor))-10, 20, 20)];
        }
        else
        {
            NSLog(@"%@", error);
            [xyResult setText:@"unable to trilaterate"];
            [selfView setHidden:YES];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [foundBeacons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLBeacon *currentBeacon = [foundBeacons objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Neue Thin" size:15.0f]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%d/%d rssi:%ld dist: %.1fm", [[currentBeacon major] intValue], [[currentBeacon minor] intValue],(long)[currentBeacon rssi], [currentBeacon accuracy]]];
    
    
    //write to a file
    
    //check if  Datafile is exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Get documents directory
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    if ([fileManager fileExistsAtPath:@"./data.json"]==YES) {
        NSLog(@"File data.json exists");
    }
    
    
    //check if the file is writable
    if ([fileManager isWritableFileAtPath:@"FilePath"]) {
        NSLog(@"isWritable");
    }else{
        NSLog(@"data file is NOT  Writable");

    }
    
    NSError* error = nil;
    NSString *data;
    data = [NSString stringWithFormat:@"%d/%d rssi:%ld dist: %.1fm", [[currentBeacon major] intValue], [[currentBeacon minor] intValue],(long)[currentBeacon rssi], [currentBeacon accuracy]];
    
    NSString *contents = [NSString stringWithContentsOfFile:@"./data.json"
                                        encoding:NSUTF8StringEncoding
                                                      error:&error];
    
    contents = [contents stringByAppendingString:data];
    
    [contents writeToFile:@"./data.json"
            atomically:YES
            encoding:NSUnicodeStringEncoding
            error:&error];
    
    
    // JSON not working
    
//    NSArray* jsonResponse = [NSJSONSerialization JSONObjectWithData:theResponse
//                                                            options:kNilOptions
//                                                              error:&error];
//    //create json data
//    [NSString initData  setText:[NSString stringWithFormat:@" {\"currentBeacon major\" : \"%d\"/%d rssi:%ld dist: %.1fm", [[currentBeacon major] intValue], [[currentBeacon minor] intValue],(long)[currentBeacon rssi], [currentBeacon accuracy]]];
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDetails
//                                                       options:kNilOptions
//                                                         error:&error];
//    [jsonData setObject:@"firstobject" forKey:@"aKey"];
    
    

    
    
    return cell;
    
    
    
    
    
}




@end
