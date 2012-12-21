//
//  ConnectionController.m
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionController.h"

@implementation ConnectionController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
    }
    return self;
}


-(void)establishConnection:(NSString*) mHost: (int) mPort{
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)mHost, mPort, &readStream, &writeStream);
    
    inputStream = (NSInputStream *)readStream;
    outputStream = (NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}

//- (void)sendData:(NSString*)data{
//    [outputStream write:(const uint8_t *)[data cStringUsingEncoding:NSASCIIStringEncoding] maxLength:[data length]];
//}

//- (void)sendData:(UInt8) type{
- (void)sendData:(NSMutableData *) payload {
    [outputStream write:[payload bytes] maxLength:[payload length]];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
    NSLog(@"New event");
	NSString *io;
	
	if (theStream == inputStream) io = @">>";
	else io = @"<<";
	NSString *event;
	switch (streamEvent)
	{
		case NSStreamEventNone:
			event = @"NSStreamEventNone";
			//_info.text = @"Can not connect to the host!";
            conStatus = @"Can not connect to the host!";
			break;
		case NSStreamEventOpenCompleted:
			event = @"NSStreamEventOpenCompleted";
            conStatus = @"Connected";
			break;
		case NSStreamEventHasBytesAvailable:
			event = @"NSStreamEventHasBytesAvailable";
			if (theStream == inputStream)
			{
				uint8_t buffer[1024];
				int len;
				while ([inputStream hasBytesAvailable])
				{
					len = [inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0)
					{
						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
						NSData *theData = [[NSData alloc] initWithBytes:buffer length:len];
						if (nil != output)
						{
							//NSArray *arr = [output componentsSeparatedByString:@"\n"];
							NSLog(@"%@", output);
							[output release];
						}
					}
				}
			}
			break;
		case NSStreamEventHasSpaceAvailable:
			event = @"NSStreamEventHasSpaceAvailable";
			
			break;
		case NSStreamEventErrorOccurred:
			event = @"NSStreamEventErrorOccurred";
			//_info.text = @"Can not connect to the host!";
            conStatus = @"Can not connect to the host!";
			break;
		case NSStreamEventEndEncountered:
			event = @"NSStreamEventEndEncountered";
            conStatus = @"Connection closed by host";
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [theStream release];
            theStream = nil;
			
			break;
		default:
			event = @"** Unknown";
	}
	
    [self.delegate connectionStatusChanged:conStatus];
	NSLog(@"%@ : %@", io, event);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{

    [delegate release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
