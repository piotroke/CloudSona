//
//  RandomSelector.h
//  CloudSona2
//
//  Created by Piotr Dąbrowski on 26.09.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomSelector : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource> {
    int selectedRow;
}

-(void)chooseRandom;
-(int)selectedValue;

@end
