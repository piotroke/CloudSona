//
//  Utils.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@implementation Utils
+(MainViewController*)getMainVC {
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MainViewController *mainVC = (MainViewController*)del.window.rootViewController;

    return mainVC;
}

+(void)showModalVC:(UIViewController*)vc animated:(BOOL)animated {
    MainViewController *mvc = [Utils getMainVC];
    
    [mvc presentModalViewController:vc animated:animated];
}


@end
