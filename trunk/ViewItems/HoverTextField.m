//
//  CalendarItem.m
//  CSWeekView Demo
//
//  Created by Elijah on 8/28/12.
//  Copyright (c) 2012 DiaryCloud.com (Thomas Johnson). All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "HoverTextField.h"

@implementation HoverTextField

- (void)mouseEntered:(NSEvent *)theEvent
{
    if (is_underlined)
        return;
    is_underlined = YES;
    
    NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
    [mutParaStyle setAlignment: (int)[self getHoverAlign]];
    
    NSDictionary *attrsDictionary =   [[NSMutableDictionary alloc] initWithCapacity:2];
    [attrsDictionary setValue:[NSNumber numberWithInt:NSUnderlineStyleSingle] forKey:NSUnderlineStyleAttributeName];
    [attrsDictionary setValue:mutParaStyle forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString * as =  [[NSMutableAttributedString alloc] initWithString:(NSString*)[self getHoverLabel] attributes:attrsDictionary];
    [as autorelease];
    [mutParaStyle release];
    [attrsDictionary release];
    [self setAttributedStringValue:as];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    if (!is_underlined)
        return;
    is_underlined = NO;
    
    [self setStringValue:(NSString*)[self getHoverLabel]];
}

- (void) setup
{
    
    [self setBezeled:NO];
    [self setDrawsBackground:NO];
    [self setEditable:NO];
    [self setSelectable:NO];
    self.alignment = NSLeftTextAlignment;
    self.is_underlined = NO;
    [self addTrackingRect:self.frame owner:self userData:nil assumeInside:NO];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [self click];
}

- (void) click
{
}

- (int) getHoverAlign
{
    
    return NSLeftTextAlignment;
}

- (NSString*) getHoverLabel
{
    return @"_";
}

@synthesize is_underlined;


@end
