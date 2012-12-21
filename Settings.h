//
//  Settings.h
//  CloudSona2
//
//  Created by Piotr Dąbrowski on 09.11.2012.
//
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject


@property (nonatomic) bool defaults;
@property (nonatomic) double ds_dc;
@property (nonatomic) double i_dc;
@property (nonatomic) double p_dc;
@property (nonatomic) double t_dc;
@property (nonatomic) double ds_cmdt;
@property (nonatomic) double i_pt;
@property (nonatomic) double m_bt;
@property (nonatomic) double t_cmdt;
@property (nonatomic) double t_press;
@property (nonatomic) double led;

+(id)sharedInstance;

@end
