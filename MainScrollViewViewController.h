//
//  MainScrollViewViewController.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalMenuItemViewController.h"

@interface MainScrollViewViewController : HorizontalMenuItemViewController

@property (nonatomic, retain) IBOutlet UILabel *rightlbl;
@property (retain, nonatomic) IBOutlet UILabel *leftlbl;

@end
