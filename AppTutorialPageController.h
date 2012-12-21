//
//  AppTutorialPageController.h
//  epg
//
//  Created by Kix on 11-06-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppTutorialPageController : UIViewController {
	IBOutlet UIImageView *imageView;
}

- (id) initWithImageNamed:(NSString*)imgName;
+ (AppTutorialPageController*) appTutorialPageWithImageNamed:(NSString*)imgName;

@end
