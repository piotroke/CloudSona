//
//  SettingsViewController.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "Utils.h"
#import "ConnectionController.h"
#import "OPCODE.h"

@implementation SettingsViewController
@synthesize txtFldHostIP;
@synthesize txtFldHostPort;
@synthesize lblStatus;
@synthesize txtFldDelay;
@synthesize redButtonGR1;
@synthesize greenButtonGR1;
@synthesize blueButtonGR1;
@synthesize yellowButtonGR1;
@synthesize saveButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        lblStatus.text = conStatus;
        
        self.delegate = self;
        
//        
//        if (host) {
//            txtFldHostIP.text = host;
//        }
//        
//        if(port!=0){
//            txtFldHostPort.text = [NSString stringWithFormat:@"%d", port];
//        }
//        
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)establishUIElements {
    [self establishSliders];
    [self establishSteppers];
    [self setSSID];
    buttons = [[NSMutableArray alloc] initWithCapacity:6];
    [buttons addObject:btnTest1];
    [buttons addObject:btnTest2];
    [buttons addObject:btnWakeUp];
    [buttons addObject:btnSleep];
    [buttons addObject:btnSave];
    
    [txtFldHostIP setKeyboardType:UIKeyboardTypeNumberPad];
    [txtFldHostPort setKeyboardType:UIKeyboardTypeNumberPad];
    
    for (int i=0; i<buttons.count; i++) {
        ((UIButton *) [buttons objectAtIndex:i]).layer.cornerRadius = 5.0f;
    }
}

-(void)establishSliders {
    ds_dc_slider.maximumValue = DS_DC_MAX;
    ds_dc_slider.minimumValue = DS_DC_MIN;
    ds_dc_slider.value = DS_DC_DEFAULT;
    i_dc_slider.maximumValue = I_DC_MAX;
    i_dc_slider.minimumValue = I_DC_MIN;
    i_dc_slider.value = I_DC_DEFAULT;
    p_dc_slider.maximumValue = P_DC_MAX;
    p_dc_slider.minimumValue = P_DC_MIN;
    p_dc_slider.value = P_DC_DEFAULT;
    t_dc_slider.maximumValue = T_DC_MAX;
    t_dc_slider.minimumValue = T_DC_MIN;
    t_dc_slider.value = T_DC_DEFAULT;
    ds_cmdt_slider.maximumValue = DS_CMDT_MAX;
    ds_cmdt_slider.minimumValue = DS_CMDT_MIN;
    ds_cmdt_slider.value = DS_CMDT_DEFAULT;
    i_pt_slider.maximumValue = I_PT_MAX;
    i_pt_slider.minimumValue = I_PT_MIN;
    i_pt_slider.value = I_PT_DEFAULT;
    m_bt_slider.maximumValue = M_BT_MAX;
    m_bt_slider.minimumValue = M_BT_MIN;
    m_bt_slider.value = M_BT_DEFAULT;
    t_cmdt_slider.maximumValue = T_CMDT_MAX;
    t_cmdt_slider.minimumValue = T_CMDT_MIN;
    t_cmdt_slider.value = T_CMDT_DEFAULT;
    tpress_slider.maximumValue = TPRESS_MAX;
    tpress_slider.minimumValue = TPRESS_MIN;
    tpress_slider.value = TPRESS_DEFAULT;
    led_int_slider.maximumValue = LED_INT_MAX;
    led_int_slider.minimumValue = LED_INT_MIN;
    led_int_slider.value = LED_INT_DEFAULT;
}

-(void)establishSteppers {
    ds_dc_stepper.maximumValue = DS_DC_MAX;
    ds_dc_stepper.minimumValue = DS_DC_MIN;
    ds_dc_stepper.value = DS_DC_DEFAULT;
    ds_dc_stepper.stepValue = DS_DC_STEP;
    i_dc_stepper.maximumValue = I_DC_MAX;
    i_dc_stepper.minimumValue = I_DC_MIN;
    i_dc_stepper.value = I_DC_DEFAULT;
    i_dc_stepper.stepValue = I_DC_STEP;
    p_dc_stepper.maximumValue = P_DC_MAX;
    p_dc_stepper.minimumValue = P_DC_MIN;
    p_dc_stepper.value = P_DC_DEFAULT;
    p_dc_stepper.stepValue = P_DC_STEP;
    t_dc_stepper.maximumValue = T_DC_MAX;
    t_dc_stepper.minimumValue = T_DC_MIN;
    t_dc_stepper.value = T_DC_DEFAULT;
    t_dc_stepper.stepValue = T_DC_STEP;
    ds_cmdt_stepper.maximumValue = DS_CMDT_MAX;
    ds_cmdt_stepper.minimumValue = DS_CMDT_MIN;
    ds_cmdt_stepper.value = DS_CMDT_DEFAULT;
    ds_cmdt_stepper.stepValue = DS_CMDT_STEP;
    i_pt_stepper.maximumValue = I_PT_MAX;
    i_pt_stepper.minimumValue = I_PT_MIN;
    i_pt_stepper.value = I_PT_DEFAULT;
    i_pt_stepper.stepValue = I_PT_STEP;
    m_bt_stepper.maximumValue = M_BT_MAX;
    m_bt_stepper.minimumValue = M_BT_MIN;
    m_bt_stepper.value = M_BT_DEFAULT;
    m_bt_stepper.stepValue = M_BT_STEP;
    t_cmdt_stepper.maximumValue = T_CMDT_MAX;
    t_cmdt_stepper.minimumValue = T_CMDT_MIN;
    t_cmdt_stepper.value = T_CMDT_DEFAULT;
    t_cmdt_stepper.stepValue = T_CMDT_STEP;
    tpress_stepper.maximumValue = TPRESS_MAX;
    tpress_stepper.minimumValue = TPRESS_MIN;
    tpress_stepper.value = TPRESS_DEFAULT;
    tpress_stepper.stepValue = TPRESS_STEP;
    led_int_stepper.maximumValue = LED_INT_MAX;
    led_int_stepper.minimumValue = LED_INT_MIN;
    led_int_stepper.value = LED_INT_DEFAULT;
    led_int_stepper.stepValue = LED_INT_STEP;
}

-(void)setSSID {
    NSArray *ifs = (id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        NSDictionary *dict = CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        info = (id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
//        NSLog(@"%@", [dict objectForKey:@"SSID"] );
        labelSSID.text = [dict objectForKey:@"SSID"];
        if (info && [info count]) {
            break;
        }
        [info release];
    }
    [ifs release];
}

-(void) connectionStatusChanged: (NSString*)status{
    lblStatus.text = status;
}

- (IBAction)connectClick:(id)sender {
    [self disableTestTimer];

    int mPort = txtFldHostPort.text.intValue;
    NSString *mHost = txtFldHostIP.text;
    
    [self establishConnection:mHost :mPort];
    lblStatus.text = @"Connecting...";

}


-(void)onSaveButtonClicked {
    [self saveAllValues];
    UIViewController *currentVC = [Utils getMainVC];
    [currentVC dismissModalViewControllerAnimated:YES];
}

-(void)saveAllValues {
    Connection *conn = [Connection sharedInstance];
    conn.ipAddress = txtFldHostIP.text;
    conn.port = txtFldHostPort.text;
    
    Settings *settings = [Settings sharedInstance];
    settings.defaults = false;
    settings.ds_dc = ds_dc_stepper.value;
    settings.i_dc = i_dc_stepper.value;
    settings.p_dc = p_dc_stepper.value;
    settings.t_dc = t_dc_stepper.value;
    settings.ds_cmdt = ds_cmdt_stepper.value;
    settings.i_pt = i_pt_stepper.value;
    settings.m_bt = m_bt_stepper.value;
    settings.t_cmdt = t_cmdt_stepper.value;
    settings.t_press = tpress_stepper.value;
    settings.led = led_int_stepper.value;
}


- (void)onGR1BtnClick:(id)sender{
    
    UInt8 byte1 = SET_LED_COLOR;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    UInt8 byte5;

    NSMutableData *payload = [[NSMutableData alloc] init];
    CGFloat red, green, blue, alpha;

    byte2 = GROUP1;
    
    if (sender == yellowButtonGR1)
        [[UIColor yellowColor] getRed:&red green:&green blue:&blue alpha:&alpha];
    
    if (sender == blueButtonGR1)
        [[UIColor blueColor] getRed:&red green:&green blue:&blue alpha:&alpha];

    if (sender == greenButtonGR1)
        [[UIColor greenColor] getRed:&red green:&green blue:&blue alpha:&alpha];

        
    if (sender == redButtonGR1)
        [[UIColor redColor] getRed:&red green:&green blue:&blue alpha:&alpha];
    
    
    [redButtonGR1.currentTitleColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    byte3 = (UInt8) red;
    byte4 = (UInt8) green;
    byte5 = (UInt8) blue;
    
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    [payload appendBytes:&byte5 length:sizeof(byte5)];
    
    
    [self sendData:payload];
    
    [payload release];

}


-(IBAction)startInitialBlink{
    [self disableTestTimer];
    
    UInt8 byte1 = 0x07;
    UInt8 byte2 = ALLGROUPS;
    UInt8 byte3 = EMPTY_BYTE;
    UInt8 byte4 = EMPTY_BYTE;
    UInt8 byte5 = EMPTY_BYTE;
    
//
//    UInt8 byte1 = SET_LED_COLOR;
//    UInt8 byte2;
//    UInt8 byte3;
//    UInt8 byte4;
//    UInt8 byte5;
//
//    
//    for (int i=0; i<4; i++) {
//
        NSMutableData *payload = [[NSMutableData alloc] init];
//        CGFloat red, green, blue, alpha;
//            
//        switch (i) {
//            case 0:
//                [[UIColor redColor] getRed:&red green:&green blue:&blue alpha:&alpha];
//                byte2 = GROUP1;
//                byte3 = (UInt8) red;
//                byte4 = (UInt8) green;
//                byte5 = (UInt8) blue;
//                break;
//            case 1:   
//                [[UIColor greenColor] getRed:&red green:&green blue:&blue alpha:&alpha];
//                byte2 = GROUP2;
//                byte3 = (UInt8) red;
//                byte4 = (UInt8) green;
//                byte5 = (UInt8) blue;
//                break;            
//            case 2:
//                [[UIColor blueColor] getRed:&red green:&green blue:&blue alpha:&alpha];
//                byte2 = GROUP3;
//                byte3 = (UInt8) red;
//                byte4 = (UInt8) green;
//                byte5 = (UInt8) blue;
//                break;
//            case 3:
//                [[UIColor yellowColor] getRed:&red green:&green blue:&blue alpha:&alpha];
//                byte2 = GROUP4;
//                byte3 = (UInt8) red;
//                byte4 = (UInt8) green;
//                byte5 = (UInt8) blue;
//                break;         
//                
//            default:
//                break;
//        }
//        
        [payload appendBytes:&byte1 length:sizeof(byte1)];
        [payload appendBytes:&byte2 length:sizeof(byte2)];
        [payload appendBytes:&byte3 length:sizeof(byte3)];
        [payload appendBytes:&byte4 length:sizeof(byte4)];
        [payload appendBytes:&byte5 length:sizeof(byte5)];
//        
//        
       [self sendData:payload];
//
//        //Delay between packets
//        //Lets UI freeze
//        //sleep(txtFldDelay.text.floatValue/1000);
 //       [NSThread sleepForTimeInterval:txtFldDelay.text.floatValue/1000];  
//        //NSLog([NSString stringWithFormat:@"Packet send #: %i", i]);
//
//        
        [payload release];
//    }
    
}

-(IBAction)toggleTest1 {
    test1Toggled = !test1Toggled;
    
    if(test1Toggled) {
//        btnTest1.layer.backgroundColor = [UIColor colorWithRed:0.19608f green:0.3098f blue:0.52157f alpha:1.0f].CGColor;
        [btnTest1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //Start timer
        test1Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadOpcode) userInfo:nil repeats:YES];
    }
    else {
        [self disableTestTimer];
    }
}

-(void) disableTestTimer {
    btnTest1.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [btnTest1 setTitleColor:[UIColor colorWithRed:0.19608f green:0.3098f blue:0.52157f alpha:1.0f] forState:UIControlStateNormal];
    [test1Timer invalidate];
    test1Timer = nil;
    
    [self sendLedColorOff];
}

-(void) loadOpcode {
    int red, green, blue;
    if (test1OpcodeToLoad == 0) {
        NSLog(@"RED");
        [btnTest1.layer setBackgroundColor:[UIColor redColor].CGColor];
        red = 7;
        green = 0;
        blue = 0;
        test1OpcodeToLoad = 1;
    }
    else if (test1OpcodeToLoad == 1) {
        NSLog(@"GREEN");
        [btnTest1.layer setBackgroundColor:[UIColor greenColor].CGColor];
        red = 0;
        green = 7;
        blue = 0;
        test1OpcodeToLoad = 2;
    }
    else {
        NSLog(@"BLUE");
        [btnTest1.layer setBackgroundColor:[UIColor blueColor].CGColor];
        red = 0;
        green = 0;
        blue = 7;
        test1OpcodeToLoad = 0;
    }
    [self sendLedColorRed:red green:green andBlue:blue];
}

-(IBAction)toggleTest2 {
    [self disableTestTimer];
    [self sendTestWith:1 andTestCase:1];
}

-(void)sendTestWith:(int)group andTestCase:(int)testCase {
    UInt8 byte1;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    UInt8 byte5;
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    byte1 = TEST;
    byte2 = group;
    byte3 = testCase;
    byte4 = EMPTY_BYTE;
    byte5 = EMPTY_BYTE;
    
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    [payload appendBytes:&byte5 length:sizeof(byte5)];
    [self sendData:payload];
    [payload release];
}

-(void)sendLedColorRed:(int)red green:(int)green andBlue:(int)blue {
    UInt8 byte0;
    UInt8 byte1;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    UInt8 byte5;
    NSMutableData *payload = [[NSMutableData alloc] init];
    
    byte0 = SET_LED_COLOR;
    byte1 = ALLGROUPS;
    byte2 = red;
    byte3 = green;
    byte4 = blue;
    byte5 = EMPTY_BYTE;
    
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
//    [payload appendBytes:&byte5 length:sizeof(byte5)];
    [self sendData:payload];
    [payload release];
}

-(void)sendLedColorOff {
    UInt8 byte0 = LED_OFF;
    UInt8 byte1 = ALLGROUPS;
    UInt8 byte2 = EMPTY_BYTE;
    UInt8 byte3 = EMPTY_BYTE;
    UInt8 byte4 = EMPTY_BYTE;
    NSMutableData *payload = [[NSMutableData alloc] init];
    [payload appendBytes:&byte0 length:sizeof(byte0)];
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    [self sendData:payload];
    [payload release];
}

-(void)onLEDSoffButtonClicked{
    [self disableTestTimer];
    
    UInt8 byte1 = 0x08;
    UInt8 byte2 = 0x80;
    UInt8 byte3 = EMPTY_BYTE;
    UInt8 byte4 = EMPTY_BYTE;
    UInt8 byte5 = EMPTY_BYTE;
    
//    UInt8 byte1 = LED_OFF;
//    UInt8 byte2 = EMPTY_BYTE;
//    UInt8 byte3 = EMPTY_BYTE;
//    UInt8 byte4 = EMPTY_BYTE;
//    UInt8 byte5 = EMPTY_BYTE;
//    
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
//    
    [payload appendBytes:&byte1 length:sizeof(byte1)];
    [payload appendBytes:&byte2 length:sizeof(byte2)];
//  
//    //Unused bits
    [payload appendBytes:&byte3 length:sizeof(byte3)];
    [payload appendBytes:&byte4 length:sizeof(byte4)];
    [payload appendBytes:&byte5 length:sizeof(byte5)];
//        
//    //Delay between packets
//    //Lets UI freeze
//    [NSThread sleepForTimeInterval:txtFldDelay.text.floatValue/1000];
//    //    NSLog([NSString stringWithFormat:@"Packet OFF send #: %i", i]);
//        
    [self sendData:payload];
    [payload release];
//    }
    
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
    [self establishUIElements];
    test1Toggled = false;
    test1OpcodeToLoad = 0;
    
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    settingsLabel.text = [NSString stringWithFormat:@"Settings v. %@",version];
    
    [self restoreValues];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViewController) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)refreshViewController {
    [self setSSID];
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self disableTestTimer];
}

-(void)restoreValues {
    Connection *conn = [Connection sharedInstance];
    txtFldHostIP.text = conn.ipAddress;
    if ([conn.ipAddress isKindOfClass:(id)[NSNull null]] || txtFldHostIP.text.length == 0) txtFldHostIP.text = @"192.168.100.101";
    txtFldHostPort.text = conn.port;
    if ([conn.port isKindOfClass:(id)[NSNull null]] || txtFldHostPort.text.length == 0) txtFldHostPort.text = @"55555";
    
    Settings *settings = [Settings sharedInstance];
    if (settings.defaults == true) {
        settings.ds_dc = DS_DC_DEFAULT;
        settings.i_dc = I_DC_DEFAULT;
        settings.p_dc = P_DC_DEFAULT;
        settings.t_dc = T_DC_DEFAULT;
        settings.ds_cmdt = DS_CMDT_DEFAULT;
        settings.i_pt = I_PT_DEFAULT;
        settings.m_bt = M_BT_DEFAULT;
        settings.t_cmdt = T_CMDT_DEFAULT;
        settings.t_press = TPRESS_DEFAULT;
        settings.led = LED_INT_DEFAULT;
    }
    
    [self setValue:settings.ds_dc forButton:ds_dc_button];
    [ds_dc_stepper setValue:settings.ds_dc];
    [ds_dc_slider setValue:settings.ds_dc];
    [self setValue:settings.i_dc forButton:i_dc_button];
    [i_dc_stepper setValue:settings.i_dc];
    [i_dc_slider setValue:settings.i_dc];
    [self setValue:settings.p_dc forButton:p_dc_button];
    [p_dc_stepper setValue:settings.p_dc];
    [p_dc_slider setValue:settings.p_dc];
    [self setValue:settings.t_dc forButton:t_dc_button];
    [t_dc_stepper setValue:settings.t_dc];
    [t_dc_slider setValue:settings.t_dc];
    [self setValue:settings.ds_cmdt forButton:ds_cmdt_button];
    [ds_cmdt_stepper setValue:settings.ds_cmdt];
    [ds_cmdt_slider setValue:settings.ds_cmdt];
    [self setValue:settings.i_pt forButton:i_pt_button];
    [i_pt_stepper setValue:settings.i_pt];
    [i_pt_slider setValue:settings.i_pt];
    [self setValue:settings.m_bt forButton:m_bt_button];
    [m_bt_stepper setValue:settings.m_bt];
    [m_bt_slider setValue:settings.m_bt];
    [self setValue:settings.t_cmdt forButton:t_cmdt_button];
    [t_cmdt_stepper setValue:settings.t_cmdt];
    [t_cmdt_slider setValue:settings.t_cmdt];
    [self setValue:settings.t_press forButton:tpress_button];
    [tpress_stepper setValue:settings.t_press];
    [tpress_slider setValue:settings.t_press];
    [self setValue:settings.led forButton:led_int_button];
    [led_int_stepper setValue:settings.led];
    [led_int_slider setValue:settings.led];
}

- (void)viewDidUnload
{

    [self setSaveButton:nil];
    [self setTxtFldHostIP:nil];
    [self setTxtFldHostPort:nil];
    [self setLblStatus:nil];
    [self setTxtFldDelay:nil];
    [self setRedButtonGR1:nil];
    [self setGreenButtonGR1:nil];
    [self setBlueButtonGR1:nil];
    [self setYellowButtonGR1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [saveButton release];
    [txtFldHostIP release];
    [txtFldHostPort release];
    [lblStatus release];
    [txtFldDelay release];
    [redButtonGR1 release];
    [greenButtonGR1 release];
    [blueButtonGR1 release];
    [yellowButtonGR1 release];
    [super dealloc];
}

-(IBAction)stepperChanged:(id)sender {
    if (sender == ds_dc_stepper) {
        ds_dc_slider.value = ds_dc_stepper.value;
        [self setValue:ds_dc_stepper.value forButton:ds_dc_button];
    }
    else if (sender == i_dc_stepper) {
        i_dc_slider.value = i_dc_stepper.value;
        [self setValue:i_dc_stepper.value forButton:i_dc_button];
    }
    else if (sender == p_dc_stepper) {
        p_dc_slider.value = p_dc_stepper.value;
        [self setValue:p_dc_stepper.value forButton:p_dc_button];
    }
    else if (sender == t_dc_stepper) {
        t_dc_slider.value = t_dc_stepper.value;
        [self setValue:t_dc_stepper.value forButton:t_dc_button];
    }
    else if (sender == ds_cmdt_stepper) {
        ds_cmdt_slider.value = ds_cmdt_stepper.value;
        [self setValue:ds_cmdt_stepper.value forButton:ds_cmdt_button];
    }
    else if (sender == i_pt_stepper) {
        i_pt_slider.value = i_pt_stepper.value;
        [self setValue:i_pt_stepper.value forButton:i_pt_button];
    }
    else if (sender == m_bt_stepper) {
        m_bt_slider.value = m_bt_stepper.value;
        [self setValue:m_bt_stepper.value forButton:m_bt_button];
    }
    else if (sender == t_cmdt_stepper) {
        t_cmdt_slider.value = t_cmdt_stepper.value;
        [self setValue:t_cmdt_stepper.value forButton:t_cmdt_button];
    }
    else if (sender == tpress_stepper) {
        tpress_slider.value = tpress_stepper.value;
        [self setValue:tpress_stepper.value forButton:tpress_button];
    }
    else if (sender == led_int_stepper) {
        led_int_slider.value = led_int_stepper.value;
        [self setValue:led_int_slider.value forButton:led_int_button];
    }
}
-(IBAction)sliderChanged:(id)sender {
    if (sender == ds_dc_slider) {
        ds_dc_stepper.value = (int)ds_dc_slider.value - ((int)ds_dc_slider.value % (int)ds_dc_stepper.stepValue);
        [self setValue:ds_dc_stepper.value forButton:ds_dc_button];
    }
    else if (sender == i_dc_slider) {
        i_dc_stepper.value = ((int)(10*i_dc_slider.value) - ((int)(10*i_dc_slider.value) % (int)(10*i_dc_stepper.stepValue)))/10.0f;
        [self setValue:i_dc_stepper.value forButton:i_dc_button];
    }
    else if (sender == p_dc_slider) {
        p_dc_stepper.value = (int)p_dc_slider.value - ((int)p_dc_slider.value % (int)p_dc_stepper.stepValue);
        [self setValue:p_dc_stepper.value forButton:p_dc_button];
    }
    else if (sender == t_dc_slider) {
        t_dc_stepper.value =(int)t_dc_slider.value - ((int)t_dc_slider.value % (int)t_dc_stepper.stepValue);
        [self setValue:t_dc_stepper.value forButton:t_dc_button];
    }
    else if (sender == ds_cmdt_slider) {
        ds_cmdt_stepper.value = (int)ds_cmdt_slider.value - ((int)ds_cmdt_slider.value % (int)ds_cmdt_stepper.stepValue);
        [self setValue:ds_cmdt_stepper.value forButton:ds_cmdt_button];
    }
    else if (sender == i_pt_slider) {
        i_pt_stepper.value = (int)i_pt_slider.value - ((int)i_pt_slider.value % (int)i_pt_stepper.stepValue);
        [self setValue:i_pt_stepper.value forButton:i_pt_button];
    }
    else if (sender == m_bt_slider) {
        m_bt_stepper.value = (int)m_bt_slider.value - ((int)m_bt_slider.value % (int)m_bt_stepper.stepValue);
        [self setValue:m_bt_stepper.value forButton:m_bt_button];
    }
    else if (sender == t_cmdt_slider) {
        t_cmdt_stepper.value = (int)t_cmdt_slider.value - ((int)t_cmdt_slider.value % (int)t_cmdt_stepper.stepValue);
        [self setValue:t_cmdt_stepper.value forButton:t_cmdt_button];
    }
    else if (sender == tpress_slider) {
        tpress_stepper.value = (int)tpress_slider.value - ((int)tpress_slider.value % (int)tpress_stepper.stepValue);
        [self setValue:tpress_stepper.value forButton:tpress_button];
    }
    else if (sender == led_int_slider) {
        led_int_stepper.value = (int)led_int_slider.value - ((int)led_int_slider.value % (int)led_int_stepper.stepValue);
        [self setValue:led_int_stepper.value forButton:led_int_button];
    }
}

-(void)setValue:(float)value forButton:(id)sender {
    if (sender == ds_dc_button) {
        [ds_dc_button setTitle:[NSString stringWithFormat:@"%.0f s", value] forState:UIControlStateNormal];
    }
    else if (sender == i_dc_button) {
        [i_dc_button setTitle:[NSString stringWithFormat:@"%.1f s", value] forState:UIControlStateNormal];
    }
    else if (sender == p_dc_button) {
        [p_dc_button setTitle:[NSString stringWithFormat:@"%.0f ms", value] forState:UIControlStateNormal];
    }
    else if (sender == t_dc_button) {
        [t_dc_button setTitle:[NSString stringWithFormat:@"%.0f ms", value] forState:UIControlStateNormal];
    }
    else if (sender == ds_cmdt_button) {
        [ds_cmdt_button setTitle:[NSString stringWithFormat:@"%.0f min", value] forState:UIControlStateNormal];
    }
    else if (sender == i_pt_button) {
        [i_pt_button setTitle:[NSString stringWithFormat:@"%.0f min", value] forState:UIControlStateNormal];
    }
    else if (sender == m_bt_button) {
        [m_bt_button setTitle:[NSString stringWithFormat:@"%.0f s", value] forState:UIControlStateNormal];
    }
    else if (sender == t_cmdt_button) {
        [t_cmdt_button setTitle:[NSString stringWithFormat:@"%.0f s", value] forState:UIControlStateNormal];
    }
    else if (sender == tpress_button) {
        [tpress_button setTitle:[NSString stringWithFormat:@"%.0f ms", value] forState:UIControlStateNormal];
    }
    else if (sender == led_int_button) {
        [led_int_button setTitle:[NSString stringWithFormat:@"%.0f", value] forState:UIControlStateNormal];
    }
}

-(IBAction)changeNetwork {
    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    [[UIApplication sharedApplication] openURL:url];
}

@end