//
//  CSEventView.h
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

// This class handles drawing a single event

#import <Cocoa/Cocoa.h>
#import "CSEventSource.h"

@interface CSEventView : NSView {
    CSEventSource *source;
}

@property (readonly) NSString *label;
@property (retain)   CSEventSource *source;

- (void) draw;

@end
