//
//  ColorPickerViewController.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderButton.h"
#import <QuartzCore/QuartzCore.h>

@protocol ColorPickerViewControllerDelegate <NSObject>
-(void)colorDroppedAtPos: (CGPoint)pos: (UIColor*) color;
@end

@interface ColorPickerViewController : UIViewController <SliderButtonDelegate>{
   
    id<ColorPickerViewControllerDelegate> cpvcDelegate;
    
    SliderButton *sliderButton;
    
    NSMutableArray *colorsCollection;
    NSMutableArray *gestureCollection;
    NSMutableArray *colorPickerButtons;
}

-(IBAction)startedToPan:(UIPanGestureRecognizer *) recognizer;
-(IBAction)onPanStop:(UIPanGestureRecognizer *) stopRecognizer: (CGPoint)initPos;

@property CGPoint initialPos;
@property (nonatomic, assign) id<ColorPickerViewControllerDelegate> cpvcDelegate;

@property (retain, nonatomic) IBOutlet UIPanGestureRecognizer *cpPanGestureRecognizer;



@end
