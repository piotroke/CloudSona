//
//  Utils.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"


@interface Utils : NSObject
+(MainViewController*)getMainVC;

+(void)showModalVC:(UIViewController*)vc animated:(BOOL)animated;
@end
