//
//  CSWeekView.h
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

//	This class handles organization of the event views, and also draws 
//		the side header ("Monday" or "M") and horizontal boundaries between the days

#import <Cocoa/Cocoa.h>
#import "CSMonthView.h"


@interface CSWeekView : NSView {
	NSString *dayName;
	NSColor *backColor;
    IBOutlet CSMonthView *monthView;
    int week_number;
}

@property (retain) NSString *dayName;
@property (retain) NSColor *backColor;
@property (assign) int week_number;
@property (assign) CSMonthView *monthView;

- (void) updateEvents: (NSArray *) events;
- (void) setupView;

@end
