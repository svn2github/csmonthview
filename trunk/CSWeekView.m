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

#import "CSWeekView.h"
#import "CSEventView.h"
#import "CSMonthView.h"
#import "CSEventSource.h"

@implementation CSWeekView

@synthesize backColor, week_number, monthView;

- (void) updateEvents: (NSArray *) events {
	NSArray *subviews = [self subviews];
	for (short svNum = [subviews count]; svNum > 0; svNum--) {
		CSEventView *thisSubview = [subviews objectAtIndex:svNum-1];
		[thisSubview removeFromSuperview];
		[thisSubview release];
	}
	
	bool occupied[kNumHoursToShow][kMaxNumSimultaneousEvents];	// this is for layout of events.  Spaces taken are marked as true.  Only kMaxNumSimultaneousEvents events at one time!
	short i, j;
	for(i = 0; i < kNumHoursToShow; i++) {
		for(j = 0; j < kMaxNumSimultaneousEvents; j++) {
			occupied[i][j] = false;
		}
	}

	NSSize newSize = NSMakeSize([self frame].size.width, kMinDayHeight);
	//[self setFrameSize:newSize];
	
	for (CSEventSource *thisEvent in events) {
		short dayOfTheWeek = [thisEvent day_of_the_week];
		NSUInteger duration     = 1;
		// figure out highest (lowest-numbered) time block that can accommodate this event
		short curRow = 0;
		short goodRow = -1;
		while (goodRow == -1) {
			BOOL foundGoodBlock = YES;
			for (NSUInteger thisTime = dayOfTheWeek; thisTime <= dayOfTheWeek + duration - 1; thisTime++) {
                if (thisTime < 7)
                {
                    if (occupied[thisTime][curRow]) {
                        foundGoodBlock = NO;
                    }
                }
                else
                {
                    NSLog(@"thistime ! <7");
                    foundGoodBlock = NO;
                    return;
                }
			}
			if (foundGoodBlock) {
				// mark those as occupied
				for (NSUInteger thisTime = dayOfTheWeek; thisTime <= dayOfTheWeek + duration - 1; thisTime++) {
					occupied[thisTime][curRow] = true;
				}
				goodRow = curRow;
			}
			curRow++;
		}
		
        
		// now we have the correct row in which to place the event, so translate that into a position within the view
		float thisWidth  = kHourWidth * duration;
		float thisLeft   = kLeftHeaderSpace + (kHourWidth *thisEvent.day_of_the_week);
        
		float myTop      = [self bounds].origin.y + [self bounds].size.height;
		float thisBottom = myTop - (kEventHeight * (goodRow + 1)) - kFromTop;
		float totalNeededHeight = myTop - thisBottom + kDayBorderBottom;
        
        
        
		if ([self frame].size.height < totalNeededHeight)
        {
			newSize = NSMakeSize([self frame].size.width, totalNeededHeight);
			float vOffset = totalNeededHeight - [self frame].size.height;
			[self setFrameSize:newSize];
            
            
			// need to move existing subviews up, since we don't autoresize
			for (NSView *thisSubView in [self subviews])
            {
				[thisSubView setFrameOrigin:NSMakePoint([thisSubView frame].origin.x, [thisSubView frame].origin.y + vOffset)];
			}
            
            
            
			// Now that we've expanded ourself, the previous bottom is potentially inaccurate
			if (thisBottom < 0) {
				thisBottom += vOffset;
			}
		}
        
        
        
		NSRect frame = NSMakeRect(thisLeft, thisBottom, thisWidth, kEventHeight);
        
        
        
		CSEventView *newEventView    = [[CSEventView alloc] initWithFrame: frame];
        newEventView.source = thisEvent;
        
		[self addSubview:newEventView];
        //[newEventView setNeedsDisplay:YES];
        [newEventView draw];
	}
    [self setupView];
}

- (void) setupView
{
    int week = [self getWeekNumber];
    // get the y value
    int height = [self frame].size.height;
    int y = self.bounds.origin.y + height - 15;
    
    // add for each day of the week
    for (int i=0; i<7; i++)
    {
        int x = kLeftHeaderSpace + (kHourWidth * i);
        int day = [monthView getDay: i forWeek:week];
        // add to this the day label
        NSRect label_frame = NSMakeRect(x, y, 30, 15);
        NSTextField *label  = [[NSTextField alloc] initWithFrame:label_frame];
        label.stringValue = [NSString stringWithFormat:@"%d",day];
        [label setBezeled:NO];
        [label setDrawsBackground:NO];
        [label setEditable:NO];
        [label setSelectable:NO];
        [self addSubview:label];
        //[label autorelease];
    }
    
}

- (int) getWeekNumber
{
    if (!week_number)
    {
        week_number = [monthView getWeekViewIndex:self] + 1;
    }
    return week_number - 1;
}

- (void)drawRect:(NSRect)rect
{
    [backColor set];
    [NSBezierPath fillRect:rect];
	NSRect myBounds = [self bounds];
    [[NSColor lightGrayColor] set];
	NSDictionary *headerAttr = [NSDictionary dictionaryWithObject: [NSFont boldSystemFontOfSize:11.0]
														   forKey:NSFontAttributeName];
	NSSize oneHeaderSize = NSMakeSize(20, myBounds.size.height);	// need to make this an ivar
	//NSRect stringRect = {myBounds.origin, oneHeaderSize};
	//[[self dayName] drawInRect:stringRect withAttributes:headerAttr];
	
	// draw top boundary
	NSBezierPath *path = [[NSBezierPath alloc] init];
	[path setLineWidth:1.0];
    
	NSPoint startPt = NSMakePoint(0, myBounds.origin.y + myBounds.size.height);
	NSPoint endPt = NSMakePoint(myBounds.size.width, myBounds.origin.y + myBounds.size.height);
    
	[path moveToPoint:startPt];
	[path lineToPoint:endPt];
	[path closePath];
	[path stroke];
	[path release];
    
    
    
}

- (void) dealloc
{
    [super dealloc];
}

@end
