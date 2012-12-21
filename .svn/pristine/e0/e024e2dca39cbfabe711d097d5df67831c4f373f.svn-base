//
//  SFScreenScrollViewViewController.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFScreenScrollViewViewController.h"
#import "HorizontalMenuViewController.h"
#import "Utils.h"

@implementation SFScreenScrollViewViewController
//@synthesize leftLbl;
//@synthesize sfssvvcDelegate;
@synthesize randomSelector;
@synthesize btnAmplitudeA;
@synthesize btnAmplitudeABGR;
@synthesize btnAmplitudeB;
@synthesize btnFreqA;
//@synthesize btnFreqB;
@synthesize btnBeat;
@synthesize btnFastBreath, btnFastHeart, btnPartyBW, btnPartyPP, btnPartyRWB, btnSlowHeart, btnSlowBreath, btnStroboscope, btnSettings, btnStart, btnLightsOff, btnRandom;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setLedPatern:(int)lpMode{
    
    UInt8 byte0 = SET_LED_PATTERN;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];

    byte2 = (UInt8) lpMode;
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
    
}



-(void)setAudioSync:(int)mode {
    
    UInt8 byte0 = SET_AUDIO_SYNC_MODE;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    byte2 = (UInt8) mode;
    
//    NSLog(@"Sync mode %d to %d", byte2, byte1);
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
}

-(void)setRandomOn:(int)value{
    uiColorBLACK = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    uiColorRED = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    uiColorORANGE = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    uiColorYELLOW = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    uiColorCHARTUESE = [UIColor colorWithRed:0.5 green:1.0 blue:0.0 alpha:1.0];
    uiColorGREEN = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    uiColorSPRINGGREEN = [UIColor colorWithRed:0.0 green:1.0 blue:0.5 alpha:1.0];
    uiColorCYAN = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    uiColorAZURE = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
    uiColorBLUE = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    uiColorVIOLET = [UIColor colorWithRed:0.5 green:0.0 blue:1.0 alpha:1.0];
    uiColorMAGENTA = [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
    uiColorROSE = [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:1.0];
    uiColorWHITE = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    uiColorPINK = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0];
    
    UInt8 byte0 = RANDOM;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorAZURE.CGColor)) {
        byte2 = 8;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorBLACK.CGColor)) {
        byte2 = 0;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorBLUE.CGColor)) {
        byte2 = 9;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorCHARTUESE.CGColor)) {
        byte2 = 4;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorCYAN.CGColor)) {
        byte2 = 7;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorGREEN.CGColor)) {
        byte2 = 5;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorMAGENTA.CGColor)) {
        byte2 = 11;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorORANGE.CGColor)) {
        byte2 = 2;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorPINK.CGColor)) {
        byte2 = 13;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorRED.CGColor)) {
        byte2 = 1;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorROSE.CGColor)) {
        byte2 = 12;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorSPRINGGREEN.CGColor)) {
        byte2 = 6;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorVIOLET.CGColor)) {
        byte2 = 10;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorWHITE.CGColor)) {
        byte2 = 13;
    }
    else if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, uiColorYELLOW.CGColor)) {
        byte2 = 3;
    }
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
}

-(void)setRandomOff {
    UInt8 byte0 = PATERN_AUDIO_RANDOM_OFF;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
}

-(void)setStart{
    UInt8 byte0 = WAKEUP;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
}

-(void) setLightsOff{
    UInt8 byte0 = PATERN_AUDIO_RANDOM_OFF;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
}
                                               
-(void)clickedOnBtn:(UITapGestureRecognizer *) recognizer {
    
    for (int i=0; i<buttons.count; i++){
       // [[buttons objectAtIndex:i] setBackgroundColor:[UIColor lightGrayColor]];
    }	
  
    if (recognizer.view == btnAmplitudeA) {
        [self setAudioSync:0];
        [self setColors];
    }
    else if (recognizer.view == btnAmplitudeB) {
        [self setAudioSync:1];
        [self setColors];
    }
    else if (recognizer.view == btnFreqA) {
        [self setAudioSync:2];
        [self setColors];
    }
/*    else if (recognizer.view == btnFreqB){
        [self setAudioSync:3];
        [self setColors];
    }*/
    else if (recognizer.view == btnBeat) {
        [self sendBeat: [randomSelector selectedValue]];
    }
    else if (recognizer.view == btnSlowBreath){
        [self setLedPatern:0];
        [self setColors];
    }
    else if (recognizer.view == btnFastBreath){
        [self setLedPatern:1];
        [self setColors];
    }
    else if (recognizer.view == btnSlowHeart){
        [self setLedPatern:2];
        [self setColors];
    }
    else if (recognizer.view == btnFastHeart){
        [self setLedPatern:3];
        [self setColors];
    }
    else if (recognizer.view == btnPartyRWB){
        [self setLedPatern:4];
        [self setColors];
    }
    else if (recognizer.view == btnPartyBW){
        [self setLedPatern:5];
        [self setColors];
    }
    else if (recognizer.view == btnStroboscope){
        [self setLedPatern:6];
        [self setColors];
    }
    else if (recognizer.view == btnPartyPP){
        [self setLedPatern:7];
        [self setColors];
        
    } else if (recognizer.view == btnStart){
        btnStart.layer.borderColor = [UIColor whiteColor].CGColor;
        [self setStart];
        [self setDisabled:1];
        btnStart.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        btnStart.enabled = FALSE;
        [self performSelector:@selector(setColors) withObject:self afterDelay:2.1];
    }
    
    else if (recognizer.view == btnLightsOff){
        btnLightsOff.layer.borderColor = [UIColor whiteColor].CGColor;
        [self setLightsOff];
        [self setDisabled:0];
        [self setGrayAll];
        btnStart.layer.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0].CGColor;
        btnStart.enabled = TRUE;
    }
    else if (recognizer.view == btnSettings) {
        [self displaySettings];
    }
    

            [UIView animateWithDuration:0.1 delay:0
                            options:nil
                            animations:^{
                                [UIView setAnimationRepeatCount:2];
                               // [recognizer.view setBackgroundColor:[UIColor redColor]];
                               // [recognizer.view setBackgroundColor:[UIColor greenColor]];
                                //[recognizer.view setBackgroundColor:[UIColor blueColor]];
                                recognizer.view.layer.borderColor = [UIColor redColor].CGColor;
                                recognizer.view.layer.borderColor = [UIColor greenColor].CGColor;
                                recognizer.view.layer.borderColor = [UIColor blueColor].CGColor;
                            }
            
                            completion:^(BOOL finished){
                                if(finished){
                                    recognizer.view.layer.borderWidth = 6;
                                    recognizer.view.layer.borderColor = [UIColor whiteColor].CGColor;
                                }
                            }
     
             ];

    [self setBorders];
    
}


-(void) randomDown {
//    [randomSelector chooseRandom];
    [self setRandomOn:[randomSelector selectedValue]];
}

-(void) randomUp {
    [self setRandomOff];
}

- (void)btnAmplitudeAanimation{
//        [UIView animateWithDuration:0.2 delay:1.0
//                            options:nil
//                         animations:^{
//                             [btnAmplitudeABGR setBackgroundColor:[UIColor redColor]];
//                             
//                         }
//         
//                         completion:^(BOOL finished){
//                             if(finished){
//                                 
//                                 
//                                 
//                                 [UIView animateWithDuration:0.4 delay:0
//                                                     options:nil
//                                                  animations:^{
//                                                      
//                                                      [btnAmplitudeABGR setBackgroundColor:[UIColor greenColor]];
//                                                  }
//                                                  completion:^(BOOL finished){
//                                                      if(finished){
//                                                          
//                                                          [UIView animateWithDuration:0.6 delay:0.0                         options:nil
//                                                                           animations:^{
//                                                                               [btnAmplitudeABGR setBackgroundColor:[UIColor blueColor]];
//                                                                           }
//                                                           
//                                                                           completion:^(BOOL finished){
//                                                                               if(finished){
//                                                                                   
//                                                                                   [self btnAmplitudeAanimation];
//                                                                               }
//                                                                           }
//                                                           ]; 
//                                                          
//                                                      }
//                                                  }
//                                  ]; 
//                                 
//                                 
//                             }
//                         }
//         ]; 
        
//    }

}


-(void)wasDroppedAt:(CGPoint)pos color:(UIColor*)color{
    CGRect btnRandomRect = [self.view convertRect:btnRandom.frame toView:self.view.superview];
    if (CGRectContainsPoint(btnRandomRect, pos) && startMode) {
        [btnRandom setBackgroundColor:color];
    }
//
//    for (int i =0; i<buttons.count; i++){
//        
//        UIButton *tmpBTN = [buttons objectAtIndex:i];        
//
//        //WTF???
//        CGRect btnRect = [self.view convertRect:tmpBTN.frame toView:self.view.superview.superview.superview];
//                
//                if(CGRectContainsPoint(btnRect, pos)){
//                    
//                    [UIView animateWithDuration:0.3 delay:0.0
//                                        options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse
//                                     animations:^{
//                                     [tmpBTN setBackgroundColor:color];
//                                     }
//                     
//                                     completion:^(BOOL finished){
//                                     }
//                     ]; 
//
//                    
//                }
//    }

}

-(void)displaySettings {
    SettingsViewController *svController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
//    presentModalViewController
    [Utils showModalVC:svController animated:YES];
    
//    [self presentModalViewController:svController animated:YES];
    
    Connection *connection = [Connection sharedInstance];
    connection.settings = svController;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    // Do any additional setup after loading the view from its nib.
    
    CGAffineTransform transLeft = CGAffineTransformMakeRotation(M_PI * -0.5);
    startMode = false;
//    CGAffineTransform transRight = CGAffineTransformMakeRotation(M_PI * 0.5);
    
//    leftLbl.transform = transLeft;
    
    [self setBorders];
 
    buttons = [[NSMutableArray alloc] initWithCapacity:17];
    [buttons addObject:btnAmplitudeA];
    [buttons addObject:btnAmplitudeB];
    [buttons addObject:btnFreqA];
    [buttons addObject:btnBeat];
//    [buttons addObject:btnFreqB];
    [buttons addObject:btnFastBreath];
    [buttons addObject:btnFastHeart];
    [buttons addObject:btnSlowBreath];
    [buttons addObject:btnSlowHeart];
    [buttons addObject:btnPartyBW];
    [buttons addObject:btnPartyPP];
    [buttons addObject:btnPartyRWB];
    [buttons addObject:btnStroboscope];
    [buttons addObject:btnSettings];
    [buttons addObject:btnStart];
    [buttons addObject:btnRandom];
    [buttons addObject:btnLightsOff];

    for (int i=0; i<buttons.count; i++){
        
        UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnBtn:)];
        [[buttons objectAtIndex:i] addGestureRecognizer:tapGestureRec];
//        NSLog(@"T: %@ %i",tapGestureRec.view, tapGestureRec.enabled);
        [tapGestureRec release];
    }
    
    [self setGrayAll];
    [self setDisabled:0];
    btnStart.layer.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0].CGColor;

    randomSelector.delegate = randomSelector;
    CGAffineTransform t0 = CGAffineTransformMakeTranslation (0, randomSelector.bounds.size.height/2);
    CGAffineTransform s0 = CGAffineTransformMakeScale       (1.0, 0.5);
    CGAffineTransform t1 = CGAffineTransformMakeTranslation (0, -randomSelector.bounds.size.height/2);
    randomSelector.transform = CGAffineTransformConcat (t0, CGAffineTransformConcat(s0, t1));
}

- (void)viewDidUnload
{
//    [self setLeftLbl:nil];
    [self setBtnAmplitudeA:nil];
    [self setBtnAmplitudeB:nil];
    [self setBtnFreqA:nil];
//    [self setBtnFreqB:nil];
    [self setBtnBeat:nil];
    [self setBtnAmplitudeABGR:nil];
    
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
//    [sfssvvcDelegate release];
//    [leftLbl release];
    [btnAmplitudeA release];
    [btnAmplitudeB release];
    [btnFreqA release];
//    [btnFreqB release];
    [btnBeat release];
    [btnAmplitudeABGR release];
    [btnRandom release];
    [btnLightsOff release];
    [btnFastBreath release];
    [btnFastHeart release];
    [btnSlowBreath release];
    [btnSlowHeart release];
    [btnPartyBW release];
    [btnPartyPP release];
    [btnPartyRWB release];
    [btnSettings release];
    [btnStart release];
    [btnStroboscope release];
    [super dealloc];
}
- (void) setColors {
 
     
    btnAmplitudeA.layer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    btnAmplitudeABGR.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0].CGColor;
    btnAmplitudeB.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    btnFreqA.layer.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0].CGColor;
//    btnFreqB.layer.backgroundColor = [].CGColor;
    btnBeat.layer.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0].CGColor;
    btnFastBreath.layer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    btnFastHeart.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    btnSlowBreath.layer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    btnSlowHeart.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    btnPartyBW.layer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    btnPartyPP.layer.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0].CGColor;
    btnPartyRWB.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    btnStroboscope.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    btnSettings.layer.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0].CGColor;
    btnStart.layer.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0].CGColor;
    btnLightsOff.layer.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0].CGColor;
    if (CGColorEqualToColor(btnRandom.backgroundColor.CGColor, [UIColor lightGrayColor].CGColor)) btnRandom.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
}

- (void) setGrayAll {
    [btnAmplitudeA setBackgroundColor:[UIColor lightGrayColor]];
    [btnAmplitudeABGR setBackgroundColor:[UIColor lightGrayColor]];
    [btnAmplitudeB setBackgroundColor:[UIColor lightGrayColor]];
    [btnFreqA setBackgroundColor:[UIColor lightGrayColor]];
//    [btnFreqB setBackgroundColor:[UIColor lightGrayColor]];
    [btnBeat setBackgroundColor:[UIColor lightGrayColor]];
    [btnFastBreath setBackgroundColor:[UIColor lightGrayColor]];
    [btnFastHeart setBackgroundColor:[UIColor lightGrayColor]];
    [btnSlowBreath setBackgroundColor:[UIColor lightGrayColor]];
    [btnSlowHeart setBackgroundColor:[UIColor lightGrayColor]];
    [btnPartyBW setBackgroundColor:[UIColor lightGrayColor]];
    [btnPartyPP setBackgroundColor:[UIColor lightGrayColor]];
    [btnPartyRWB setBackgroundColor:[UIColor lightGrayColor]];
    [btnStroboscope setBackgroundColor:[UIColor lightGrayColor]];
    [btnRandom setBackgroundColor:[UIColor lightGrayColor]];
    [btnLightsOff setBackgroundColor:[UIColor lightGrayColor]];
}

-(void) setBorders {
        
    
    
    btnAmplitudeA.layer.cornerRadius = 5;
    btnAmplitudeABGR.layer.cornerRadius = 5;
    btnAmplitudeB.layer.cornerRadius = 5;
    btnFreqA.layer.cornerRadius = 5;
//    btnFreqB.layer.cornerRadius = 5;
    btnBeat.layer.cornerRadius = 5;
    btnFastBreath.layer.cornerRadius = 5;
    btnFastHeart.layer.cornerRadius = 5;
    btnSlowBreath.layer.cornerRadius = 5;
    btnSlowHeart.layer.cornerRadius = 5;
    btnPartyBW.layer.cornerRadius = 5;
    btnPartyPP.layer.cornerRadius = 5;
    btnPartyRWB.layer.cornerRadius = 5;
    btnStroboscope.layer.cornerRadius = 5;
    btnSettings.layer.cornerRadius = 5;
    btnStart.layer.cornerRadius = 5;
    btnRandom.layer.cornerRadius = 5;
    btnLightsOff.layer.cornerRadius = 5;
    
    btnAmplitudeA.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnAmplitudeABGR.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnAmplitudeB.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnFreqA.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    btnFreqB.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnBeat.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnFastBreath.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnFastHeart.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnSlowBreath.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnSlowHeart.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnPartyBW.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnPartyPP.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnPartyRWB.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnStroboscope.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnSettings.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnStart.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnRandom.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btnLightsOff.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    btnAmplitudeA.layer.borderWidth = 5;
    btnAmplitudeABGR.layer.borderWidth = 5;
    btnAmplitudeB.layer.borderWidth = 5;
    btnFreqA.layer.borderWidth = 5;
//    btnFreqB.layer.borderWidth = 5;
    btnBeat.layer.borderWidth = 5;
    btnFastBreath.layer.borderWidth = 5;
    btnFastHeart.layer.borderWidth = 5;
    btnSlowBreath.layer.borderWidth = 5;
    btnSlowHeart.layer.borderWidth = 5;
    btnPartyBW.layer.borderWidth = 5;
    btnPartyPP.layer.borderWidth = 5;
    btnPartyRWB.layer.borderWidth = 5;
    btnStroboscope.layer.borderWidth = 5;
    btnSettings.layer.borderWidth = 5;
    btnStart.layer.borderWidth = 5;
    btnRandom.layer.borderWidth = 5;
    btnLightsOff.layer.borderWidth = 5;

    }

-(void) setDisabled:(int)mode {
    startMode = mode;
    btnAmplitudeA.enabled = mode;
    btnAmplitudeABGR.enabled = mode;
    btnAmplitudeB.enabled = mode;
    btnFreqA.enabled = mode;
//    btnFreqB.enabled = mode;
    btnBeat.enabled = mode;
    btnFastBreath.enabled = mode;
    btnFastHeart.enabled = mode;
    btnSlowBreath.enabled = mode;
    btnSlowHeart.enabled = mode;
    btnPartyBW.enabled = mode;
    btnPartyPP.enabled = mode;
    btnPartyRWB.enabled = mode;
    btnStroboscope.enabled = mode;
    btnLightsOff.enabled = mode;
    btnRandom.enabled = mode;
}

-(void)sendBeat:(int)bpm {
    NSLog(@"%d",bpm);
    
    
    UInt8 byte0 = BEAT;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2 = 15+bpm;
    UInt8 byte3;
    UInt8 byte4;
    
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    
    Connection *connection = [Connection sharedInstance];
    [connection sendData:payload];
    
    [payload release];
}

@end
