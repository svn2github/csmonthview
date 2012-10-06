//
//  CSEventView.m
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

#import "CSEventView.h"
#import "CSMonthView.h"
#import "CalendarItem.h"

@implementation CSEventView

@synthesize source;


- (id) initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	return self;
}

- (void) dealloc {
    self.source = nil;
	[super dealloc];
}

- (short) day_of_the_week
{
    return self.source.day_of_the_week;
}

- (NSString*) label
{
    return self.source.label;
}

- (void) drawRect:(NSRect)rect
{
    
}

- (void) draw {
	NSRect myBounds = [self bounds];
    
    short leftmargin = 12;
    if (self.source.align)
    {
        leftmargin = 0;
    }
    
	NSRect textFieldRect = NSMakeRect(myBounds.origin.x + leftmargin,myBounds.origin.y, kHourWidth, 15);
    
    NSString *label2 = self.label;
    
    CalendarItem *textField = [[CalendarItem alloc] initWithFrame:textFieldRect];
    textField.stringValue = label2;
    textField.source = self.source;
    [textField setup];
    textField.alignment = self.source.align;
    [self addSubview:textField];
    [textField release];
}


-(void)mouseEntered:(NSEvent *)theEvent {
    NSLog(@"mouseEntered2");
}

-(void)mouseExited:(NSEvent *)theEvent {
    NSLog(@"mouseExited2");
}

@end
