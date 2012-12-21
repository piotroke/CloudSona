//
//  AppTutorialController.m
//  epg
//
//  Created by Kix on 11-06-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HorizontalMenuViewController.h"

#import "MainScrollViewViewController.h"
#import "PFScreenScrollViewViewController.h"
#import "SFScreenScrollViewViewController.h"
#import "SettingsViewController.h"
#import "Utils.h"

@interface HorizontalMenuViewController ()
- (void)loadScrollViewWithPage:(int)page;
- (void) reload;
@end

@implementation HorizontalMenuViewController

@synthesize scrollView, pageControl, viewControllers, contentList;
//@synthesize hmVCDelegate;

- (HorizontalMenuViewController*)initWithWindow:(UIView *)pview {
	self = [super initWithNibName:@"HorizontalMenuViewController" bundle:nil];

	if(self) {
		parentView = pview;
    
//        sfssc = [[SFScreenScrollViewViewController alloc] initWithNibName:@"SFScreenScrollViewViewController" bundle:nil];
//     
//        sfssc.sfssvvcDelegate = self; 
        
        

        
    }
    
	return self;
}

/*
- (void)show {
	[self reload];
	[self.view setFrame:CGRectMake( 0, -423, 320, 460)];
	self.view.opaque = NO;
	self.view.alpha = 0.0f;
	[UIView transitionWithView:self.view duration:0.5f options:UIViewAnimationTransitionNone animations:^{
		self.view.alpha = 1.0f;
		[self.view setFrame:CGRectMake( 0, 0, 320, 460)];
	} completion:^(BOOL finished) {
		
	}];
	
	
	[parentView addSubview:self.view];
}

- (void)hide {
	if(!self.view.superview) return;
    [UIView transitionWithView:self.view duration:.5f options:UIViewAnimationTransitionNone animations:^{
        self.view.alpha = 0.0f;
		[self.view setFrame:CGRectMake(0, -423, 320, 460)];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}*/

-(void)settingsButtonPressed{
    
    SettingsViewController *svController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [Utils showModalVC:svController animated:YES];
    
    Connection *connection = [Connection sharedInstance];
    connection.settings = svController;
}

- (void)viewDidLoad
{
	pageControl.currentPage = 0;
	//[self reload];

}

- (void) reload {	
    (void)self.view;
	
	// Clear alredy preloaded pages
	for(UIView *sub in scrollView.subviews)
	{
		[sub removeFromSuperview];
	}
	
	//numberOfPages = self.contentList.count;  
    numberOfPages = 1;

    NSMutableArray *controllers = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (unsigned i = 0; i < numberOfPages; i++)
    {
		[controllers addObject:[NSNull null]];

    }
    self.viewControllers = controllers;
    [controllers release];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = numberOfPages;
	[self loadScrollViewWithPage:pageControl.currentPage - 1];
    [self loadScrollViewWithPage:pageControl.currentPage];
    [self loadScrollViewWithPage:pageControl.currentPage + 1];


}

- (void)dealloc
{

    self.viewControllers=nil;
    self.scrollView=nil;
    self.pageControl=nil;
    [super dealloc];
}


- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= numberOfPages)
        return;
    
    CGRect buttonRect = CGRectMake(83.f, 360.f, 190.f, 80.f);
    settingsButton = [[UIButton alloc] initWithFrame:buttonRect];
    //[settingsButton setBackgroundImage:[UIImage imageNamed:@"Settings.png"] forState:UIControlStateNormal];
    [settingsButton setBackgroundColor:[UIColor lightGrayColor]];
    [settingsButton addTarget:self action:@selector(settingsButtonPressed) forControlEvents:UIControlEventTouchDown];
    [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
    
    
    HorizontalMenuItemViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
   
        //UIViewController *controller = nil;
        
        switch(page) {
                
            case 0:
                controller = [[[SFScreenScrollViewViewController alloc] initWithNibName:@"SFScreenScrollViewViewController" bundle:nil] autorelease];
                break;
                
            case 1:
                controller = [[[PFScreenScrollViewViewController alloc] initWithNibName:@"PFScreenScrollViewViewController" bundle:nil] autorelease];
                break;
                
            case 2:
                controller = [[[MainScrollViewViewController alloc] initWithNibName:@"MainScrollViewViewController" bundle:nil] autorelease];
                break;
        }
        [controller.self.view addSubview:settingsButton];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    if (pageControlUsed)
    {
        return;
    }
	
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	int oldPage = pageControl.currentPage;
    BOOL pageChanged = oldPage != page;
	pageControl.currentPage = page;
    if(pageChanged) {
        NSLog(@"Did scroll");
		[self loadScrollViewWithPage:page - 1];
		[self loadScrollViewWithPage:page];
		[self loadScrollViewWithPage:page + 1];
      
        [[viewControllers objectAtIndex:oldPage] viewDidDisappear:YES];
      
        [[viewControllers objectAtIndex:page] viewDidAppear:YES];
        
        if(pageControl.currentPage ==1)
            [self stopAllFlashing];
	}
    
}
             
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;

}

- (IBAction)changePage:(id)sender
{
    [self setPage:pageControl.currentPage animated:YES];
    
}

-(void)setPage:(int)num animated:(BOOL)animated;
{
    int page = num;
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:animated];
    
    pageControlUsed = YES;
    
    pageControl.currentPage = num;

}

-(void)wasDroppedAtPos:(CGPoint)pos color:(UIColor*)color {
    [(HorizontalMenuItemViewController*)[viewControllers objectAtIndex:pageControl.currentPage] wasDroppedAt:pos color:color];
}




-(void)stopAllFlashing{
dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    UInt8 byte1 = LED_OFF;
    UInt8 byte2 = ALLGROUPS;
    UInt8 byte3 = EMPTY_BYTE;
    UInt8 byte4 = EMPTY_BYTE;
    UInt8 byte5 = EMPTY_BYTE;
    
    Connection *connection = [Connection sharedInstance];
    
    //DEPRECATED
//    for (int i=0; i<4; i++) {
//        
        NSMutableData *payload = [[NSMutableData alloc] init];        
//        switch (i) {
//            case 0:
//                byte2 = GROUP1;
//                break;
//            case 1:   
//                byte2 = GROUP2;
//                break;            
//            case 2:
//                byte2 = GROUP3;
//                break;
//            case 3:
//                byte2 = GROUP4;
//                break;         
//                
//            default:
//                break;
//        }
        
        [payload appendBytes:&byte1 length:sizeof(byte1)];
        [payload appendBytes:&byte2 length:sizeof(byte2)];
        
        //Unused bits
        [payload appendBytes:&byte3 length:sizeof(byte3)];
        [payload appendBytes:&byte4 length:sizeof(byte4)];
        [payload appendBytes:&byte5 length:sizeof(byte5)];
        
        //Delay between packets
        //Lets UI freeze
        
        [connection sendData:payload];
        
        [payload release];
        //NSLog(@"OFF PACKET %i", i);
    
    
    dispatch_async( dispatch_get_main_queue(), ^{
        // Add code here to update the UI/send notifications based on the
        // results of the background processing
    });
});
}


@end
