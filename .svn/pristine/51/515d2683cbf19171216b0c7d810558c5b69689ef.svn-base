//
//  PFScreenOptionsViewController.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFScreenOptionsViewControllerDelegate <NSObject>

-(void) patternSelected:(UIImageView*) imgView patternNum:(int)patternNum;

@end

@interface PFScreenOptionsViewController : UITableViewController{
    
    NSMutableArray *patternsCollection;
    
}

@property (nonatomic,assign) id <PFScreenOptionsViewControllerDelegate> delegate;

@end
