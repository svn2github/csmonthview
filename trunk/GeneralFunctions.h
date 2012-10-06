//
//  GeneralFunctions.h
//  CSMonthView DEMO
//
//  Created by Elijah on 10/5/12.
//  Copyright (c) 2012 Elijah. All rights reserved.
//  Free for personal and commercial use. (GNU Lesser GPL - any version)
//

#import <Foundation/Foundation.h>

@interface GeneralFunctions : NSObject

+ (NSArray*) getCurrentDateComponents;
+ (NSArray*) getMysqlDateComponents: (NSString*) date;

+ (NSString*) getMysqlDate: (NSDate*)date;

@end
