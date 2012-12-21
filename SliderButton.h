//
//  SliderButton.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class SliderButton;

@protocol SliderButtonDelegate <NSObject>
-(void)sliderButton:(SliderButton*)sb didToggleActive:(BOOL)active;
-(void)sliderButton:(SliderButton*)sb didSliderPositionChange:(float)pos;
-(void)sliderButton:(SliderButton*)sb didEnable:(BOOL)enable;
@end

@interface SliderButton : UIViewController
{
    id<SliderButtonDelegate> sliderButtonDelegate;
    UIImage *csSliderLogo;
    
}
- (IBAction)switchValueChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UISwitch *toggleButton;
@property (retain, nonatomic) IBOutlet UISlider *powerLvlSlider;
@property (readwrite, assign, nonatomic) BOOL wasAlrdyActive;
@property (retain, nonatomic) UIColor *bgrColor;
@property (readwrite, assign, nonatomic) float sliderLvl;
@property (retain, nonatomic) IBOutlet UIButton *buttonInBGR;

@property (nonatomic, assign) id<SliderButtonDelegate> sliderButtonDelegate;
@end
