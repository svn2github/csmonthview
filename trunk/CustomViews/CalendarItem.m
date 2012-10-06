//
//  CalendarItem.m
//  CSWeekView Demo
//
//  Created by Elijah on 9/6/12.
//
//

#import "CalendarItem.h"

@implementation CalendarItem

@synthesize source;

- (void) click
{
    [self.source click];
}

- (NSString*) getHoverLabel
{
    return self.source.label;
}

- (int) getHoverAlign
{
    return self.source.align;
}

@end
