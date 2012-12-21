//
//  Settings.m
//  CloudSona2
//
//  Created by Piotr Dąbrowski on 09.11.2012.
//
//

#import "Settings.h"

@implementation Settings

@synthesize defaults, ds_dc, i_dc, p_dc, t_dc, ds_cmdt, i_pt, m_bt, t_cmdt, t_press, led;

static Settings *sharedInstance = nil;

+(Settings *) sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
        sharedInstance.defaults = true;
    }
    return sharedInstance;
}

@end
