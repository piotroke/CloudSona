//
//  Connection.h
//  CloudSona2
//
//  Created by Fake on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsViewController.h"

@interface Connection : NSObject

@property (nonatomic, assign) SettingsViewController *settings;
@property (nonatomic, retain) NSString *ipAddress;
@property (nonatomic, retain) NSString *port;
@property (nonatomic, retain) NSString *delay;

+(id)sharedInstance;

-(void) establishConnection:(NSString*) mHost: (int) mPort;
-(void) sendData:(NSMutableData *) payload;

@end
