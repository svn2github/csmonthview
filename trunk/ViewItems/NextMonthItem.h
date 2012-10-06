//
//  NextMonthItem.h
//  EncryptedDiary-Cocoa
//
//  Created by Elijah on 9/6/12.
//
//

#import "HoverTextField.h"
#import "CalendarWindowMac.h"

@interface NextMonthItem : HoverTextField
{
    NSString *label;
    BOOL nextMonth;
    CalendarWindowMac *viewController;
}

@property (retain) NSString *label;
@property (readwrite) BOOL nextMonth;
@property (assign) CalendarWindowMac *viewController;

@end
