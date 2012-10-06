//
//  CSEventSource.m
//  CSWeekView Demo
//
//  Created by Elijah on 9/1/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "CSEventSource.h"

@implementation CSEventSource

@synthesize week_number,day_of_the_week;
@synthesize label;
@synthesize align;


- (void) click
{
    NSLog(@"%@",self.label);
}


/* just a function for testing with bogus data as it does not check whether it is the
 same month, or the next or last.
 */
- (void) setWithCSCalendarMonth: (CSCalendarMonth*) calendarMonth andDay: (short) day
{
    [self setWithCSCalendarMonth:calendarMonth andMonth:calendarMonth.month andDay:day];
}

/* the "CalendarMonth" is month rounded off by the week and sometimes including they days in
 the month before and/or after */
- (void) setWithCSCalendarMonth: (CSCalendarMonth*) calendarMonth andMonth: (short) month andDay: (short) day
{
    self.week_number     = [calendarMonth getNumberOfWeeksForMonth:month andDay:day];
    self.day_of_the_week = [calendarMonth getWeekdayForDay:day andWeek:self.week_number];
}

@end
