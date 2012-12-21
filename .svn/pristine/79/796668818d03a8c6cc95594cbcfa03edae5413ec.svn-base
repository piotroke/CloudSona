//
//  HorizontalMenuViewController.h
//  epg
//
//  Created by Kix on 11-06-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFScreenScrollViewViewController.h"
#import "Connection.h"

//@protocol HorizontalMenuViewControllerDelegate <NSObject>
//-(void)currentVisiblePage:(int)page;
//@end

//@interface HorizontalMenuViewController : UIViewController <UIScrollViewDelegate> {
@interface HorizontalMenuViewController : UIViewController <UIScrollViewDelegate> {

    //id<HorizontalMenuViewControllerDelegate> hmVCDelegate;
    
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
	NSMutableArray *contentList;
	int numberOfPages;
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
	UIView *parentView;
    UIButton *settingsButton;

}
//@property (nonatomic, assign) id<HorizontalMenuViewControllerDelegate> hmVCDelegate;

@property (nonatomic, retain) NSMutableArray *contentList;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@property (nonatomic, retain) NSMutableArray *viewControllers;

- (HorizontalMenuViewController*)initWithWindow:(UIView*)pview;
//- (void)show;
//- (void)hide;
- (void)reload;
- (IBAction)changePage:(id)sender;
-(void)setPage:(int)num animated:(BOOL)animated;

-(void)wasDroppedAtPos:(CGPoint)pos color:(UIColor*)color;
-(void)settingsButtonPressed;
-(void)stopAllFlashing;


@end
