//
//  SlidersViewController.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderButton.h"
#import "Connection.h"
#import "OPCODE.h"
#import <QuartzCore/QuartzCore.h>
//#import "MainViewController.h"

@protocol SlidersViewControllerDelegate <NSObject>
-(void)buttonToggleActive:(BOOL)active atIndex:(int)index;
-(void) wasDroppedAtPos:(CGPoint)pos: (UIColor*) color;
@end


@interface SlidersViewController : UIViewController <SliderButtonDelegate>
{
    NSMutableArray *buttons;

    id<SlidersViewControllerDelegate> slidersDelegate;
}

@property (retain, nonatomic) IBOutlet UIView *sliderViewControllerView;
@property (assign, nonatomic) id<SlidersViewControllerDelegate> slidersDelegate;

-(void)wasDroppedAtPos:(CGPoint)pos color:(UIColor*)color;
-(void)sendPayload:(NSMutableData *)payload;

@end
