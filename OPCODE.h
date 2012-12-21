//
//  OPCODE.h
//  CloudSona2
//
//  Created by Kamil Zaborszczyk on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef CloudSona2_OPCODE_h
#define CloudSona2_OPCODE_h



#endif

#define EMPTY_BYTE 0x00;

#define SET_LED_COLOR 0x01;
#define LED_OFF 0x02;
#define SET_BLINK_RATE 0x03;
#define SET_LED_PATTERN 0x04;
#define SET_AUDIO_SYNC_MODE 0x05;
#define SET_DEFAULT_TIMEOUT 0x06;
#define WAKEUP 0x07;
#define SLEEP 0x08;
#define RANDOM 0x09;
#define PATERN_AUDIO_RANDOM_OFF 0x0A;
#define SET_TIMING_PARAM 0x0B;
#define BEAT 0x0C;
#define TEST 0x0D;
#define USER_COMMAND_4 0x0E;
#define RESET_INIT 0x0F;

#define GROUP1 0x01;
#define GROUP2 0x02;
#define GROUP3 0x03;
#define GROUP4 0x04;
#define ALLGROUPS 0x80;