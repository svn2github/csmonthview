//
//  CSMonthView.h
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
//
//	This is the parent custom view class for a weekly calendar, organized horizontally.
//		It contains five CSWeekView, from top to bottom, each the full width of the CSMonthView.
//		It will resize itself to accommodate the needed expansion of the CSWeekView, which may not overlap.
//		It draws the headers (hour labels) and vertical boundaries between hours.
//
//	CSMonthView expects to receive events as a 5-member NSArray (one per day).  Each member
//		is itself an NSArray of NSDictionaries, each of which represents the details for a single event.
//
//	Start times and durations are handled as integers.  In my conception, each represents a half-hour, but it could be 
//		different for you.
//
//	Constants are currently handled as properties of the CSMonthView, but could be moved easily to a separate constants file
//		if necessary, or set explicitly as constants in the respective headers.

//	CSMonthView future improvements:
//		- allow drag and drop of events, notifying the week view of changes and propagating them to some controller
//		- optimize updates to allow only minimal redrawing when events are moved/removed (instead of needing to feed all events back in through updateEvents:)
//		- allow highlighting of sets of events (and subsequent alteration of those sets via methods or drag&drop)
//		- smarter resizing: shrink day views to small minimum sizes, equally if possible, and expand them equally to full size of CSMonthView (less top header)
//		- IB Palette

#import <Cocoa/Cocoa.h>
#import "CSCalendarMonth.h"

// Layout constants:
#define kWeekWidth 85	//pixels
#define kHourWidth kWeekWidth	//pixels
#define kTopHeaderSpace 20
#define kLeftHeaderSpace 0	// the left header is handled by the day views, but we set it here to be able to calculate the correct initial size of the week view
#define kEventHeight 18
#define kMinDayHeight 70
#define kHeaderFontSize 11
#define kDayBorderBottom 10


#define kHeaderSpace 50;


#define kFromTop 20

// Model constants:
#define kMinutesPerTimeUnit 60 // how many minutes a time unit represents
#define kHourZero 0		// what hour a start time of zero represents
#define kNumHoursToShow 7	// how many hours should be displayed
#define	kMaxNumSimultaneousEvents 50	// how many simultaneous events there could possibly be (set this generously)

@class CSWeekView;

@interface CSMonthView : NSView {
	IBOutlet CSWeekView *week1;
	IBOutlet CSWeekView *week2;
	IBOutlet CSWeekView *week3;
	IBOutlet CSWeekView *week4;
	IBOutlet CSWeekView *week5;
	IBOutlet CSWeekView *week6;
    
    CSCalendarMonth *calendar;

}

- (void) updateEvents: (NSArray *) events;

- (int) getDay: (int) weekday forWeek: (int) week;
- (int) getNumberOfWeeks;
- (void) setYear: (int) year andMonth: (int) month;

- (NSArray*) getWeeks;
- (int) getWeekViewIndex: (CSWeekView*) weekView;

+ (NSArray*) getEventsArrayFromList: (NSArray*)data;


@property (assign) CSWeekView *week1;
@property (assign) CSWeekView *week2;
@property (assign) CSWeekView *week3;
@property (assign) CSWeekView *week4;
@property (assign) CSWeekView *week5;
@property (assign) CSWeekView *week6;
@property (retain) CSCalendarMonth *calendar;

@end
