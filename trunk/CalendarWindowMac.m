//
//  HomeScreenMac.m
//  EncryptedDiary-Cocoa
//
//  Created by Elijah on 8/29/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "CalendarWindowMac.h"
#import "CSMonthView.h"
#import "CSWeekView.h"
#import "CSEventView.h"
#import "CSCalendarMonth.h"
#import "HoverTextField.h"
#import "NextMonthItem.h"
#import "GeneralFunctions.h"

@interface CalendarWindowMac ()

@end

@implementation CalendarWindowMac

- (id) initWindow
{
    self = [super initWithWindowNibName:@"CalendarWindow.Mac"];
    [self showWindow:nil];
    
    return self;
}

- (void) windowDidLoad
{
    [super windowDidLoad];
    
    NSArray *today = [GeneralFunctions getCurrentDateComponents];
    self.year = [(NSNumber*)[today objectAtIndex:0] intValue];
    self.month =[(NSNumber*)[today objectAtIndex:1] intValue];
    [self loadCalendar];
}

- (void) nextMonth
{
    if (month == 12)
    {
        year++;
        month = 1;
    }
    else{
        month++;
    }
    [self reloadCalendar];
    
}

- (void) lastMonth
{
    if (month == 1)
    {
        year--;
        month = 12;
    }
    else
        month--;
    [self reloadCalendar];
}

- (void) reloadCalendar
{
    for (NSTrackingArea *tr in [self.window.contentView trackingAreas])
    {
        [self.window.contentView removeTrackingArea:tr];
    }
    [self.window.contentView setSubviews:[NSArray array]];
    self.monthView = nil;
    [self loadCalendar];
    return;
    
    /*
    CSCalendarMonth *calendar = [[CSCalendarMonth alloc] init];
    [calendar setYear:year andMonth:month];
    [calendar autorelease];
    
    monthView.calendar = calendar;
    

    
    self.window.title = [NSString stringWithFormat:@"%@ %d",calendar.monthName,calendar.year];
    
    // create a list of events or times
    NSMutableArray *times  = [DiaryDates getTimesForCalendarMonth:calendar];
    [EntryTimeItem trimArray:times above:2  andMin: 1];
    NSArray *events = [CSMonthView getEventsArrayFromList:times];
    
    short number_of_weeks = [calendar getNumberOfWeeks];
    
    
    //NSRect frame = self.window.frame;
    int header_space = 20;
    int h = header_space+kMinDayHeight*(number_of_weeks+1);
    int w = kWeekWidth*7+kLeftHeaderSpace;
    int week_height = kMinDayHeight;
    NSLog(@"weeks: %d height: %d",number_of_weeks+1,h);
    
    NSRect windowFrame = NSMakeRect(100, 100, w+40, h+60);
    [self.window setFrame:windowFrame display:NO];
    
    NSRect monthFrame = self.monthView.frame;
    monthFrame.size.height = h;
    [self.monthView setFrame:monthFrame];
    
    
    NSArray *weeks = [monthView getWeeks];
    int i = 0;
    for (CSWeekView *week in weeks)
    {
        int h2 = - header_space + h-kMinDayHeight*(i+1);
        NSLog(@"week: %d, start height: %d height: %d",i,h2,week_height);
        NSRect rect2 = NSMakeRect(0, h2, w, week_height);
        [week setSubviews:[NSArray array]];
        [week setFrame:rect2];
        i++;
    }
    
    
    
    
    
    [monthView updateEvents:events]; */
}

- (void) loadCalendar
{
    CSCalendarMonth *calendar = [[CSCalendarMonth alloc] init];
    [calendar setYear:self.year andMonth:self.month];
    [calendar autorelease];
    
    
    
    
    self.window.title = [NSString stringWithFormat:@"%@ %d",calendar.monthName,calendar.year];
    
    // create a list of events or times
    NSMutableArray *times  = [[NSMutableArray alloc] initWithCapacity:5];
    
    CSEventSource *item;
    
    item = [[CSEventSource alloc] init];
    item.day_of_the_week = 5;
    item.week_number = 1;
    item.label = @"a";
    
    [times addObject:item];
    
    
    item = [[CSEventSource alloc] init];
    [item setWithCSCalendarMonth:calendar andMonth:calendar.month andDay:5];
    item.label = @"a";
    
    [times addObject:item];
    
    if (calendar.start_day > 0)
    {
        // on the last day of last month
        item = [[CSEventSource alloc] init];
        [item setWithCSCalendarMonth:calendar andMonth:calendar.month-1 andDay:calendar.days_in_last_month];
        item.label = @"a";
        
        [times addObject:item];
        
        // on the first day of next month
        item = [[CSEventSource alloc] init];
        [item setWithCSCalendarMonth:calendar andMonth:calendar.month+1 andDay:1];
        item.label = @"a";
        
        [times addObject:item];
        
    }
    
    NSArray *events = [CSMonthView getEventsArrayFromList:times];
    
    short number_of_weeks = [calendar getNumberOfWeeks];
    
    int header_space = 20;
    int h = header_space+kMinDayHeight*(number_of_weeks+1);
    int w = kWeekWidth*7+kLeftHeaderSpace;
    int week_height = kMinDayHeight;
    //NSLog(@"weeks: %d height: %d",number_of_weeks+1,h);
    
    
    NSRect windowFrame = NSMakeRect(100, 100, w+40, h+60 +20);
    
    // next month and last month
    NSRect next_month_rect = NSMakeRect(w - 55, windowFrame.size.height - 60, 100, 30);
    NSRect last_month_rect = NSMakeRect(20, windowFrame.size.height - 60, 100, 30);
    
    
    NextMonthItem *last = [[NextMonthItem alloc] initWithFrame:last_month_rect];
    [last setup];
    last.stringValue = last.label = @"Last Month";
    last.nextMonth = NO;
    last.viewController = self;
    [self.window.contentView addTrackingRect:last_month_rect owner:last userData:nil assumeInside:NO];
    [self.window.contentView addSubview:last];
    [last autorelease];
    
    
    NextMonthItem *next = [[NextMonthItem alloc] initWithFrame:next_month_rect];
    [next setup];
    next.stringValue = next.label = @"Next Month";
    next.nextMonth = YES;
    next.viewController = self;
    [self.window.contentView addTrackingRect:next_month_rect owner:next userData:nil assumeInside:NO];
    [self.window.contentView addSubview:next];
    [next autorelease];
    
    NSRect rect = NSMakeRect(20, 20, w, h);
    monthView = [[CSMonthView alloc] initWithFrame:rect];
    monthView.calendar = calendar;
    
    monthView.week1 = [CSWeekView alloc];
    monthView.week2 = [CSWeekView alloc];
    monthView.week3 = [CSWeekView alloc];
    monthView.week4 = [CSWeekView alloc];
    monthView.week5 = [CSWeekView alloc];
    monthView.week6 = [CSWeekView alloc];
    
    NSArray *weeks = [monthView getWeeks];
    int i = 0;
    for (CSWeekView *week in weeks)
    {
        int h2 = - header_space + h-kMinDayHeight*(i+1);
        //NSLog(@"week: %d, start height: %d height: %d",i,h2,week_height);
        NSRect rect2 = NSMakeRect(0, h2, w, week_height);
        [week initWithFrame:rect2];
        [monthView addSubview:week];
        week.monthView = monthView;
        i++;
    }
    
    
    //NSLog(@"%d - height",h);
    
    [self.window setFrame:windowFrame display:YES];
    
    [[self.window contentView] addSubview:monthView];
    [monthView awakeFromNib];
    [monthView updateEvents:events];
    //[self close];
}


- (void) dealloc
{
    [super dealloc];
}

//@synthesize calendar;
@synthesize year,month;

@end
