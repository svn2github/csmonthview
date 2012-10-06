//
//  NextMonthItem.m
//  EncryptedDiary-Cocoa
//
//  Created by Elijah on 9/6/12.
//
//

#import "NextMonthItem.h"

@implementation NextMonthItem

- (void) click
{
    if (self.nextMonth)
    {
        [self.viewController nextMonth];
    }
    else
    {
        [self.viewController lastMonth];
    }
}

- (NSString*) getHoverLabel
{
    return label;
}

- (void) dealloc
{
    label = nil;
    [super dealloc];
}

@synthesize label,nextMonth,viewController;

@end
