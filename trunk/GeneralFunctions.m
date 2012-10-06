//
//  GeneralFunctions.m
//  CSMonthView DEMO
//
//  Created by Elijah on 10/5/12.
//  Copyright (c) 2012 Elijah. All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import "GeneralFunctions.h"

@implementation GeneralFunctions

+ (NSArray*) getCurrentDateComponents
{
    NSDate *date = [[NSDate alloc] init];
    NSString *string = [self getMysqlDate:date];
    [date release];
    return [self getMysqlDateComponents: string];
}

+ (NSArray*) getMysqlDateComponents: (NSString*) date
{
    NSArray *a = [date componentsSeparatedByString:@"-"];
    if([a count] != 3){
        return nil;
    }
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:[[a objectAtIndex:0] intValue]],
            [NSNumber numberWithInt:[[a objectAtIndex:1] intValue]],
            [NSNumber numberWithInt:[[a objectAtIndex:2] intValue]],
            nil];
}

+ (NSString*) getMysqlDate: (NSDate*)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *a = [df stringFromDate:date];
    [df release];
    return a;
}

@end
