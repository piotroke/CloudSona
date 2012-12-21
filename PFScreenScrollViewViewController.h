//
//  PFScreenScrollViewViewController.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFScreenOptionsViewController.h"
#import "HorizontalMenuItemViewController.h"

//@interface PFScreenScrollViewViewController: UIViewController <HorizontalMenuViewControllerDelegate>



@interface PFScreenScrollViewViewController: HorizontalMenuItemViewController <PFScreenOptionsViewControllerDelegate>
{
    //HorizontalMenuViewController *horizontalMenuVC;
    UISwipeGestureRecognizer *gestRecUP;
    // SHOW OPTIONS
    
    PFScreenOptionsViewController *pfsovc;

    BOOL finishAnimation;

}

@property (retain, nonatomic) IBOutlet UILabel *rightLbl;
@property (retain, nonatomic) IBOutlet UILabel *seekBarLbl;
@property (retain, nonatomic) IBOutlet UIImageView *patternImgView;
@property (retain, nonatomic) IBOutlet UILabel *patternNrLbl;

-(void)performSeekBarTransformation;
-(void) swipeUpGesture;
-(void) startPatternFlash:(int)patrnIdx;

@end
