//
//  CSEventSource.h
//  CSWeekView Demo
//
//  Created by Elijah on 9/1/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import <Foundation/Foundation.h>
#import "CSCalendarMonth.h"

@interface CSEventSource : NSObject
{
    short week_number;
    short day_of_the_week;
    short align;
    NSString *label;
}
- (void) click;
- (void) setWithCSCalendarMonth: (CSCalendarMonth*) calendarMonth andDay: (short) day;
- (void) setWithCSCalendarMonth: (CSCalendarMonth*) calendarMonth andMonth: (short) month andDay: (short) day;

@property (readwrite) short week_number;
@property (readwrite) short day_of_the_week;
@property (readwrite) short align;
@property (retain) NSString *label;

@end
