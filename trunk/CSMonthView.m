//
//  CSMonthView.m
//
//  Created by David Hirsch on 12/17/09.
//  Copyright 2009 David Hirsch (CSMonthView@davehirsch.com)
/*
 This file is part of CSMonthView.
 
 CSMonthView is free software: you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 CSMonthView is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License
 along with CSMonthView.  If not, see <http://www.gnu.org/licenses/>.
 */ 

#import "CSMonthView.h"
#import "CSWeekView.h"
#import "CSEventSource.h"

@implementation CSMonthView


- (void) awakeFromNib {
    
	// set up my subviews
	[week1 setDayName:@"M"];
	[week2 setDayName:@"T"];
	[week3 setDayName:@"W"];
	[week4 setDayName:@"R"];
	[week5 setDayName:@"F"];
    
    
	NSColor *color = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    [week1 setBackColor:color];
    [week2 setBackColor:color];
    [week3 setBackColor:color];
    [week4 setBackColor:color];
    [week5 setBackColor:color];
    [week6 setBackColor:color];
    
	short curTop = [self frame].size.height - kTopHeaderSpace;
	short curBottom = curTop;
    
    
    int num_weeks = [self getNumberOfWeeks];
    
    NSArray *weeks  = [self getWeeks];
    NSEnumerator *e = [weeks objectEnumerator];
    CSWeekView *week;
    int i = 1;
    while (week = [e nextObject])
    {
        if (num_weeks >=i)
        {
            curBottom -= [week frame].size.height;
            [week setFrameOrigin:NSMakePoint(0, curBottom)];
        }
        i++;
    }
    
    
    [self draw];
}

- (void) drawRect:(NSRect)rect
{
    // erase the background by drawing white
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:rect];
    
	//NSDictionary *headerAttr = [NSDictionary dictionaryWithObject: [NSFont boldSystemFontOfSize:kHeaderFontSize]
    //						forKey:NSFontAttributeName];
	//NSSize oneHeaderSize = NSMakeSize(kHourWidth, kTopHeaderSpace);
    //[[NSColor blueColor] set]; 
    
    NSRect myBounds = [self bounds];
	short initialLeft = kLeftHeaderSpace;
	for (short dowNum=0; dowNum <= kNumHoursToShow-1; dowNum++)
    {
		short dow = dowNum + kHourZero;
		if (dow > 12) dow -= 12;
		NSPoint rectPos = NSMakePoint(initialLeft + dowNum * kHourWidth, myBounds.size.height - kTopHeaderSpace);
        
		// Draw Vertical lines for hours
		NSBezierPath *path = [[NSBezierPath alloc] init];
		[path setLineWidth:1.0];
        
		NSPoint startPt = NSMakePoint(initialLeft + dowNum * kHourWidth, myBounds.size.height);
		NSPoint endPt   = NSMakePoint(initialLeft + dowNum * kHourWidth, 0);
		[path moveToPoint:startPt];
		[path lineToPoint:endPt];
		[path closePath];
        [[NSColor lightGrayColor] set];
		[path stroke];
		[path release];
	}
}

- (void) draw
{
	NSRect myBounds = [self bounds];
	short initialLeft = kLeftHeaderSpace;
    NSArray *arr    = [NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
	for (short dowNum=0; dowNum <= kNumHoursToShow-1; dowNum++)
    {
		short dow = dowNum + kHourZero;
		if (dow > 12) dow -= 12;
		NSPoint rectPos = NSMakePoint(initialLeft + dowNum * kHourWidth, myBounds.size.height - kTopHeaderSpace);
        
        
        NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
        [mutParaStyle setAlignment:NSCenterTextAlignment];
        [mutParaStyle autorelease];
        
        NSFont *font = [NSFont boldSystemFontOfSize:12];
        
        NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithCapacity:1];
        [d setValue:font forKey:NSFontAttributeName];
        [d setValue:mutParaStyle forKey:NSParagraphStyleAttributeName];
        [d autorelease];
        
        
        NSAttributedString *a  = [[NSAttributedString alloc] initWithString:[arr objectAtIndex:dow] attributes:d];
        [a autorelease];
        
        NSRect textFieldRect   = NSMakeRect(rectPos.x, rectPos.y +4, kHourWidth, 15);
        NSTextField *textField = [[NSTextField alloc] initWithFrame:textFieldRect];
        [textField setAttributedStringValue:a];
        [textField setBezeled:NO];
        [textField setDrawsBackground:NO];
        [textField setEditable:NO];
        [textField setSelectable:NO];
        textField.alignment = NSCenterTextAlignment;
        textField.autoresizingMask = NSViewMinYMargin;
        [self addSubview:textField];
        [textField release];
	}
}

- (NSArray*) getWeeks
{
    NSArray *arr = [NSArray arrayWithObjects:week1,week2,week3,week4,week5,week6, nil];
    return arr;
}

- (void) updateEvents: (NSArray *) events {
    //return;
	[week1 updateEvents: [events objectAtIndex:0]];
	[week2 updateEvents: [events objectAtIndex:1]];
	[week3 updateEvents: [events objectAtIndex:2]];
	[week4 updateEvents: [events objectAtIndex:3]];
	[week5 updateEvents: [events objectAtIndex:4]];
	[week6 updateEvents: [events objectAtIndex:5]];

	// now the day views have resized themselves vertically, so resize me and reposition them to fit
	//[self resizeWithOldSuperviewSize: NSMakeSize(0, 0)];

}

- (void)resizeWithOldSuperviewSize:(NSSize)oldBoundsSize {
    //return NSMakeSize(100, 100);
    return;
	// I must be at least as tall as my superview (the scrollview's content view)
	NSSize scrollContentSize = [(NSScrollView *)[[self superview] superview] contentSize];
    int num_weeks = [self getNumberOfWeeks];
	short neededHt = kTopHeaderSpace 
					+ [week1 frame].size.height
					+ [week2 frame].size.height
                    + [week3 frame].size.height;
    if (num_weeks >=4)
        neededHt += [week4 frame].size.height;
    if (num_weeks >=5)
        neededHt += [week5 frame].size.height;
    if (num_weeks >=6)
        neededHt += [week6 frame].size.height;
	short minHt = scrollContentSize.height;
	NSSize curSize = [self frame].size;
	short newHt = MAX(minHt, neededHt);
	[self setFrameSize:NSMakeSize(curSize.width, newHt)];
}

- (int) getWeekViewIndex: (CSWeekView*) weekView
{
    __block int index = -1;
    NSArray *weeks = [self getWeeks];
    [weeks enumerateObjectsUsingBlock:^(id obj, NSUInteger index2, BOOL *stop){
        if (weekView == obj)
            index = index2;
    }];
    return index;
}


- (int) getNumberOfWeeks
{
    return [self.calendar getNumberOfWeeks];
}

- (int) getDay: (int) weekday forWeek: (int) week
{
    return [self.calendar getDay:weekday forWeek:week];
}


- (void) setYear: (int) in_year andMonth: (int) in_month
{
    self.calendar = [[CSCalendarMonth alloc] init];
    [self.calendar setYear:in_year andMonth:in_month];
}

+ (NSArray*) getEventsArrayFromList: (NSArray*)data
{
    // Need to give the week view all the events it needs to display
	NSMutableArray *events = [NSMutableArray arrayWithCapacity:5];
	NSMutableArray *dayEvents;
	for (short week = 0; week <6; week++) {
		NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"week_number == %d", week];
		NSArray *theseDayInstances = [data filteredArrayUsingPredicate:dayPredicate];
		dayEvents = [NSMutableArray arrayWithCapacity:[theseDayInstances count]];
		for (CSEventSource *thisObj in theseDayInstances) {
			//NSDictionary *thisEvent = [NSDictionary dictionaryWithObjectsAndKeys:
			//						   [NSNumber numberWithInt: [thisObj startTime]], @"dayOfTheWeek",
			//						   [thisObj name], @"label",
			//						   nil];
			[dayEvents addObject:thisObj];
		}
		[events addObject:dayEvents];
	}
    return events;
}

- (void) dealloc
{
    [super dealloc];
}

@synthesize week1,week2,week3,week4,week5,week6,calendar;

@end
