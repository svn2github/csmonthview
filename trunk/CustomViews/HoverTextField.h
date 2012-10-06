//
//  CalendarItem.h
//  CSWeekView Demo
//
//  Created by Elijah on 8/28/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import <Cocoa/Cocoa.h>
#import "CSEventView.h"

@protocol CSClickable <NSObject>



@end

@interface HoverTextField : NSTextField
{
    BOOL is_underlined;
}

- (void) setup;
- (void) click;
- (NSString*) getHoverLabel;
- (int) getHoverAlign;

@property (assign) BOOL is_underlined;

@end
