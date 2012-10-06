//
//  AppDelegate.m
//  CSMonthView DEMO
//
//  Created by Elijah on 10/5/12.
//  Copyright (c) 2012 Elijah. All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "AppDelegate.h"
#import "CalendarWindowMac.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[CalendarWindowMac alloc] initWindow];
}

@end
