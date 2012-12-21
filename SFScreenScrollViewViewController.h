//
//  SFScreenScrollViewViewController.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPCODE.h"
#import "HorizontalMenuItemViewController.h"
#import "RandomSelector.h"
#import <QuartzCore/QuartzCore.h>
//
//@protocol SFScreenScrollViewViewControllerDelegate <NSObject>
////-(void)wasDroppedAt:(CGPoint)pos color:(UIColor*)color;
//@end

@interface SFScreenScrollViewViewController : HorizontalMenuItemViewController <UIGestureRecognizerDelegate> {
    
//    id<SFScreenScrollViewViewControllerDelegate> sfssvvcDelegate;

    NSMutableArray *buttons;
    BOOL btnAmplitudeAanimate;
    BOOL startMode;
    NSTimer *myTimer;
    
    UIColor *uiColorBLACK;
    UIColor *uiColorRED;
    UIColor *uiColorORANGE;
    UIColor *uiColorYELLOW;
    UIColor *uiColorCHARTUESE;
    UIColor *uiColorGREEN;
    UIColor *uiColorSPRINGGREEN;
    UIColor *uiColorCYAN;
    UIColor *uiColorAZURE;
    UIColor *uiColorBLUE;
    UIColor *uiColorVIOLET;
    UIColor *uiColorMAGENTA;
    UIColor *uiColorROSE;
    UIColor *uiColorWHITE;
    UIColor *uiColorPINK;
}

//@property (retain, nonatomic) IBOutlet UILabel *leftLbl;

//@property (assign, nonatomic) id<SFScreenScrollViewViewControllerDelegate> sfssvvcDelegate;
@property (retain, nonatomic) IBOutlet RandomSelector *randomSelector;

@property (retain, nonatomic) IBOutlet UIButton *btnAmplitudeA;
@property (retain, nonatomic) IBOutlet UILabel *btnAmplitudeABGR;

@property (retain, nonatomic) IBOutlet UIButton *btnAmplitudeB;
@property (retain, nonatomic) IBOutlet UIButton *btnFreqA;
//@property (retain, nonatomic) IBOutlet UIButton *btnFreqB;
@property (retain, nonatomic) IBOutlet UIButton *btnBeat;
@property (retain, nonatomic) IBOutlet UIButton *btnSlowBreath;
@property (retain, nonatomic) IBOutlet UIButton *btnFastBreath;
@property (retain, nonatomic) IBOutlet UIButton *btnSlowHeart;
@property (retain, nonatomic) IBOutlet UIButton *btnFastHeart;
@property (retain, nonatomic) IBOutlet UIButton *btnPartyRWB;
@property (retain, nonatomic) IBOutlet UIButton *btnPartyBW;
@property (retain, nonatomic) IBOutlet UIButton *btnStroboscope;
@property (retain, nonatomic) IBOutlet UIButton *btnPartyPP;
@property (retain, nonatomic) IBOutlet UIButton *btnSettings;
@property (retain, nonatomic) IBOutlet UIButton *btnStart;
@property (retain, nonatomic) IBOutlet UIButton *btnLightsOff;
@property (retain, nonatomic) IBOutlet UIButton *btnRandom;

-(IBAction)randomDown;
-(IBAction)randomUp;
//-(IBAction)clickedOnBtn:(UITapGestureRecognizer *) recognizer;
-(void)clickedOnBtn:(UITapGestureRecognizer *) recognizer;
-(void)btnAmplitudeAanimation;
-(void)displaySettings;
-(void)setAudioSync:(int) mode;
-(void)setLedPatern:(int) lpMode;
-(void)setRandomOn:(int) value;
-(void)setRandomOff;
-(void)setStart;
-(void)setBorders;
-(void)setGrayAll;
-(void)setColors;
-(void)setDisabled:(int)mode;
-(void)sendBeat:(int)bpm;

@end
