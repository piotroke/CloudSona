//
//  MainScrollViewViewController.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScrollViewViewController.h"

@implementation MainScrollViewViewController
@synthesize rightlbl;
@synthesize leftlbl;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
      if (self) {
        // Custom initialization

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
    
    CGAffineTransform transLeft = CGAffineTransformMakeRotation(M_PI * -0.5);
    CGAffineTransform transRight = CGAffineTransformMakeRotation(M_PI * 0.5);
    
    rightlbl.transform = transRight;
    leftlbl.transform = transLeft;
}

- (void)viewDidUnload
{
    [self setRightlbl:nil];
    [self setLeftlbl:nil];
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

    [rightlbl release];
    [leftlbl release];
    [super dealloc];
}
@end
