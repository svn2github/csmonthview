//
//  CSCalendarMonth.h
//  CSWeekView Demo
//
//  Created by Elijah on 9/1/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import <Foundation/Foundation.h>

@interface CSCalendarMonth : NSObject
{
    int month;
    int year;
    
    int start_day;
    int days_in_month;
    int days_in_last_month;
    
    NSString *monthName;
}

// last month and next month
- (int) getLastMonth;
- (int) getLastMonthYear;
- (int) getNextMonth;
- (int) getNextMonthYear;

// functions related to the first and last day on the month calendar
- (NSNumber*) getMinYear;
- (NSNumber*) getMinMonth;
- (NSNumber*) getMinDay;
- (BOOL) endsOnSaturday;
- (NSNumber*) getMaxYear;
- (NSNumber*) getMaxMonth;
- (NSNumber*) getMaxDay;

// functions for calculating the days and weeks and initialization
- (int) getWeekdayForDay: (int) day_number andWeek: (int) week;
- (int) getNumberOfWeeksForMonth: (int) month andDay: (int) day;
- (int) getDay: (int) weekday forWeek: (int) week;
- (void) setYear: (int) year andMonth: (int) month;
- (int) getNumberOfWeeks;

- (void) testMonth;

@property (assign) int year;
@property (assign) int month;
@property (assign) int start_day;
@property (assign) int days_in_month;
@property (assign) int days_in_last_month;
@property (retain) NSString *monthName;


@end
