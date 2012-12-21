//
//  PFScreenScrollViewViewController.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PFScreenScrollViewViewController.h"
#import "Utils.h"
#import "OPCODE.h"
#import "SFScreenScrollViewViewController.h"
#import "PFScreenOptionsViewController.h"


@implementation PFScreenScrollViewViewController
@synthesize rightLbl;
@synthesize seekBarLbl;
@synthesize patternImgView;
@synthesize patternNrLbl;


-(void) patternSelected:(UIImageView*) imgView patternNum:(int)patternNum{
    patternImgView.image = imgView.image;
    patternNrLbl.text = [NSString stringWithFormat:@"%d", patternNum+1]; 
    //patternImgView = imgView;
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    [self startPatternFlash: patternNum];

    });    
        
}

-(void) startPatternFlash:(int) patrnIdx {
    
    UInt8 byte1 = SET_LED_PATTERN;
    UInt8 byte2 = ALLGROUPS;
    UInt8 byte3 = patrnIdx;
    UInt8 byte4 = 0x6;
    UInt8 byte5 = EMPTY_BYTE;
    
    Connection *connection = [Connection sharedInstance];
    NSMutableData *payload = [[NSMutableData alloc] init];
        
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];        
    [payload appendBytes:&byte5 length:sizeof(byte5)];
        
    [connection sendData:payload];
        
    [payload release];
    

    
}


-(void)swipeUpGesture{
    //Show options
    pfsovc = [[[PFScreenOptionsViewController alloc] initWithNibName:@"PFScreenOptionsViewController" bundle:nil] autorelease];
    pfsovc.delegate = self;
    [Utils showModalVC:pfsovc animated:YES];

}

-(void)viewDidAppear:(BOOL)animated
{
    finishAnimation = NO;
    [self performSeekBarTransformation];
    
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated 
{
    
    finishAnimation = YES;
    
    [super viewDidDisappear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        horizontalMenuVC = [[HorizontalMenuViewController alloc] initWithNibName:@"HorizontalMenuViewController" bundle:nil];
//        horizontalMenuVC.hmVCDelegate = self;
//      

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
    CGAffineTransform transRight = CGAffineTransformMakeRotation(M_PI * 0.5);
    
    rightLbl.transform = transRight;



    
     gestRecUP = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpGesture)]autorelease ];
    
    [gestRecUP setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:gestRecUP];
    
}


-(void)performSeekBarTransformation{
    
    [UIView animateWithDuration:3.0 delay:0.0
                        options:UIViewAnimationCurveLinear
                     animations:^{seekBarLbl.transform = CGAffineTransformMakeTranslation(patternImgView.frame.size.width-10.0, 0);}
     
                     completion:^(BOOL finished){
                         
                         if (finished != finishAnimation){
                             seekBarLbl.transform = CGAffineTransformMakeTranslation(0,0);
                             [self performSeekBarTransformation];
                         }
                     }
     ]; 
}
     
- (void)viewDidUnload
{
    
    [self setRightLbl:nil];
    [self setSeekBarLbl:nil];
    [self setPatternImgView:nil];
    [self setPatternNrLbl:nil];
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
//    [horizontalMenuVC dealloc];
    [rightLbl release];
    [seekBarLbl release];
    [patternImgView release];

    [patternNrLbl release];
    [super dealloc];
}


@end
