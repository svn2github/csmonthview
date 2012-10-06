//
//  CSCalendarMonth.m
//  CSWeekView Demo
//
//  Created by Elijah on 9/1/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "CSCalendarMonth.h"

@implementation CSCalendarMonth


- (int) getLastMonth
{
    if (self.month == 1)
        return 12;
    else return self.month - 1;
}

- (int) getLastMonthYear
{
    if (self.month == 1)
        return self.year - 1;
    return self.year;
}

- (int) getNextMonth
{
    if (self.month == 12)
        return 1;
    return self.month + 1;
}

- (int) getNextMonthYear
{
    if (self.month == 12)
        return self.year + 1;
    return self.year;
}

- (NSNumber*) getMinYear
{
    int year2 = self.year;
    if (self.start_day)
        year2 = [self getLastMonthYear];
    return [NSNumber numberWithInt:year2];
}



- (NSNumber*) getMinMonth
{
    int month2 = self.month;
    if (self.start_day)
        month2 = [self getLastMonth];
    return [NSNumber numberWithInt:month2];
}

- (NSNumber*) getMinDay
{
    int day2 = 1;
    if (self.start_day)
    {
        day2 = days_in_last_month - start_day + 1;
    }
    return [NSNumber numberWithInt:day2];
}


- (BOOL) endsOnSaturday
{
    int days = self.start_day + self.days_in_month;
    int r    = days % 7;
    if (r == 0)
        return YES;
    else
        return NO;
}

- (NSNumber*) getMaxYear
{
    int year2 = self.year;
    if (![self endsOnSaturday])
        year2 = [self getNextMonthYear];
    return [NSNumber numberWithInt:year2];
}

- (NSNumber*) getMaxMonth
{
    int month2 = self.month;
    if (![self endsOnSaturday])
        month2 = [self getNextMonth];
    return [NSNumber numberWithInt:month2];
}

- (NSNumber*) getMaxDay
{
    int day2 = self.days_in_month;
    if (![self endsOnSaturday])
    {
        int days = start_day + days_in_month;
        day2 = 7 - days % 7; // the remainder of days
    }
    return [NSNumber numberWithInt:day2];
}

- (int) getNumberOfWeeksForMonth: (int) day_month andDay: (short) day_day
{
    if (self.month == 1 && day_month == 12)
        return 0;
    if (self.month == 12 && day_month == 1)
        return [self getNumberOfWeeks];
    if (day_month < month)
        return 0;
    if (day_month > month)
        return [self getNumberOfWeeks];
    
    // if the day is within the month
    int days_from_corner = (int)day_day + self.start_day;
    int result = (days_from_corner + 7 - 1)/7 -1; // ceil(A/B) == (A + B - 1)/B
    return result;
}

- (int) getWeekdayForDay: (int) day_number andWeek: (int) week
{
    int days_from_corner = 0;
    if (week >0)
    {
        if (day_number < 7 && week > 1)
            days_from_corner = start_day + days_in_month + day_number;
        else
            days_from_corner = start_day + day_number;
    }
    else {
        // if this is the first weeek
        if (day_number > 7)
            days_from_corner =  start_day - (days_in_last_month - day_number);
        else
            days_from_corner = start_day + day_number;
    }
    int result = (days_from_corner - 1) % 7;
    if (result > 6 || result < 0)
    {
        NSLog(@"Day of the week too large or small: %d",result);
        result = 1;
    }
        
    return result;
}

- (int) getNumberOfWeeks
{
    int days_min = self.days_in_month + self.start_day;
    for (int i = 6; i>=3; i--)
    {
        if (days_min > (i-1)*7 && days_min <= i*7)
        {
            return i - 1;
        }
    }
    NSLog(@"error: num_weeks");
    return 0;
}


- (void) setYear: (int) in_year andMonth: (int) in_month
{
    year  = in_year;
    month = in_month;
    
    int month_last = [self getLastMonth];
    int month_last_year = [self getLastMonthYear];
    
    NSCalendar *gregorian  = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSString *dayOneString = [NSString stringWithFormat:@"%d-%d-01",year,month];
    NSString *dayOneLastMonthString = [NSString stringWithFormat:@"%d-%d-01",month_last_year ,month_last];
    
    
    NSDateFormatter * dateformatter= [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dayOneDate          = [dateformatter dateFromString:dayOneString];
    NSDate *dayOneLastMonthDate = [dateformatter dateFromString:dayOneLastMonthString];
    [dateformatter release];
    
    // get the start day
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:dayOneDate];
    self.start_day = [weekdayComponents weekday] -1;
    // weekday 1 = Sunday for Gregorian calendar
    
    // get the number of days in the month
    NSRange days = [gregorian rangeOfUnit:NSDayCalendarUnit 
                                   inUnit:NSMonthCalendarUnit 
                                  forDate:dayOneDate];
    self.days_in_month = days.length;
    
    // get the number of days in the last month
    days = [gregorian rangeOfUnit:NSDayCalendarUnit 
                           inUnit:NSMonthCalendarUnit 
                          forDate:dayOneLastMonthDate];
    self.days_in_last_month = days.length;
    
    
    // NSDateComponents *dateComponents = [gregorian components:( NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit) fromDate:dayOneDate]; 
    // NSInteger year2 = [dateComponents year];
    // NSInteger month2 = [dateComponents month];
    
    // set the month title
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    self.monthName = [formatter stringFromDate:dayOneDate];
    [formatter release];
    
    // get the number of days in the last month
    
    [gregorian release];
}

- (int) getDay: (int) weekday forWeek: (int) week
{
    int days_from_corner = 7*week + weekday;
    int day;
    if (days_from_corner < self.start_day)
    {
        day = self.days_in_last_month - self.start_day + days_from_corner;
    }
    else {
        int month_days = days_from_corner - self.start_day;
        if (self.days_in_month > month_days)
        {
            day = month_days;
        }
        else {
            day = month_days - days_in_month;
        }
    }
    return day + 1;
}

- (void) testMonth
{
    NSLog(@"start %@",self.monthName);
    int weeks = [self getNumberOfWeeks];
    
    int days[6][6];
    
    int max_days = 7;
    
    max_days = 4;
    weeks = 0;
    
    int from_corner = 0;
    for (int i = 0; i<= weeks;i++)
    {
        for (int ii = 0; ii< max_days; ii++) {
            int day = [self getDay:ii forWeek:i];
            int weekday = [self getWeekdayForDay:day andWeek:i];
            days[i][ii] = day;
            from_corner++;
            NSLog(@"%d %d %d",weekday,day,i);
        }
    }
    NSLog(@"done %@",self.monthName);
}

- (void) dealloc
{
    [monthName release];
    [super dealloc];
}

@synthesize month,year,days_in_month,days_in_last_month,start_day,monthName;

@end
