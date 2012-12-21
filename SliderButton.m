//
//  SliderButton.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SliderButton.h"

@implementation SliderButton
@synthesize toggleButton;
@synthesize sliderButtonDelegate;
@synthesize powerLvlSlider;
@synthesize wasAlrdyActive;
@synthesize sliderLvl;
@synthesize buttonInBGR;
@synthesize bgrColor;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
        csSliderLogo = [UIImage imageNamed:@"cs_logo.png"];
        
    }
    return self;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //Rotate slider
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * -0.5);
    powerLvlSlider.transform = trans;
    
    CGImageRef imageRef = [csSliderLogo CGImage];
    UIImage *rotatedImage = [ UIImage imageWithCGImage:imageRef scale:5.0 orientation:UIImageOrientationRight];
    
    [powerLvlSlider setThumbImage:rotatedImage forState: UIControlStateNormal];
    
    //Make Sliderbar invisible
    UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"hideMySlider.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"hideMySlider.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
  
    [powerLvlSlider setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
    [powerLvlSlider setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
   // buttonInBGR.layer.borderColor = [UIColor darkGrayColor].CGColor;
    buttonInBGR.layer.cornerRadius = 15;

    wasAlrdyActive = NO;
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    buttonInBGR.highlighted = true;
    [self.sliderButtonDelegate sliderButton:self didEnable:true];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    buttonInBGR.highlighted = false;
    [self.sliderButtonDelegate sliderButton:self didEnable:false];
}

- (void)viewDidUnload
{
    [self setToggleButton:nil];
    [self setButtonInBGR:nil];
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

    [powerLvlSlider release];
    [toggleButton release];
    [buttonInBGR release];
    [super dealloc];
}
- (IBAction)switchValueChanged:(id)sender {
    if(self.sliderButtonDelegate) {
        [self.sliderButtonDelegate sliderButton:self didToggleActive:self.toggleButton.on];
    }
}

- (IBAction)sliderValueChanged:(id)sender {
    if(self.sliderButtonDelegate) {
        [self.sliderButtonDelegate sliderButton:self didSliderPositionChange:sliderLvl];
    }
}
@end
