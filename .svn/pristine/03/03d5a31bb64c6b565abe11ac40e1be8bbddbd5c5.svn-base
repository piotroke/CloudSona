//
//  Connection.m
//  CloudSona2
//
//  Created by Fake on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"

@implementation Connection

@synthesize settings, ipAddress, port, delay;

static Connection *sharedInstance = nil;

+(Connection *) sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

-(void)establishConnection:(NSString*) mHost: (int) mPort {
    [settings establishConnection:mHost :mPort];
}

- (void)sendData:(NSMutableData *) payload {
    [settings sendData:payload];
    [NSThread sleepForTimeInterval:delay.floatValue/1000];
}

-(void) dealloc {
    [super dealloc];
    [settings release];
    [ipAddress release];
    [port release];
}

@end
