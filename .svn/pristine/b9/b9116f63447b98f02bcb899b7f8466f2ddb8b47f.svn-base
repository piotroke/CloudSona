//
//  RandomSelector.m
//  CloudSona2
//
//  Created by Piotr Dąbrowski on 26.09.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RandomSelector.h"

@implementation RandomSelector

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"Picker view");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 225;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSLog(@"%d %f", row, 15.0f + (225.0f*log10(row+1)));
//    double value = 15.0f + (225.0f*log10(row+1));
    double value = 15.0f + row;
    return [NSString stringWithFormat:@"%.0f", value];
}

-(void)chooseRandom {
    selectedRow = rand()%10;
    [self selectRow:selectedRow inComponent:0 animated:YES];
}

-(int)selectedValue {
    return [self selectedRowInComponent:0];
}

@end
