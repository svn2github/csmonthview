//
//  CalendarItem.h
//  CSWeekView Demo
//
//  Created by Elijah on 9/6/12.
//
//

#import <Cocoa/Cocoa.h>

#import "HoverTextField.h"
#import "CSEventSource.h"

@interface CalendarItem : HoverTextField

{
    CSEventSource *source;
}

@property (assign) CSEventSource *source;

@end
