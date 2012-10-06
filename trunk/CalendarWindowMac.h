//
//  HomeScreenMac.h
//  EncryptedDiary-Cocoa
//
//  Created by Elijah on 8/29/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "CSCalendarMonth.h"
#import "CSMonthView.h"

@interface CalendarWindowMac : NSWindowController
{
    //CSCalendarMonth *calendar;
    int year;
    int month;
    CSMonthView *monthView;
}

- (id) initWindow;
- (void) loadCalendar;
- (void) reloadCalendar;
- (void) lastMonth;
- (void) nextMonth;

//@property (retain) CSCalendarMonth *calendar;
@property (readwrite) int year;
@property (readwrite) int month;
@property (retain,atomic) CSMonthView *monthView;

@end
