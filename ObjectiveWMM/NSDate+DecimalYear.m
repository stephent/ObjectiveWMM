//
//  NSDate+DecimalYear.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import "NSDate+DecimalYear.h"

@implementation NSDate (DecimalYear)

- (double) decimalYear {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
    NSDateComponents *dateComponents = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
                                                              | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self];
	
    NSDateComponents *startOfYearComponents =  [[NSDateComponents alloc] init];
    [startOfYearComponents setDay:1];
    [startOfYearComponents setMonth:1];
    [startOfYearComponents setYear:[dateComponents year]];
    NSDate *startOfYear = [gregorian dateFromComponents:startOfYearComponents];
    
    NSDateComponents *startOfNextYearComponents =  [[NSDateComponents alloc] init];
    [startOfNextYearComponents setDay:1];
    [startOfNextYearComponents setMonth:1];
    [startOfNextYearComponents setYear:[dateComponents year] + 1];
    NSDate *startOfNextYear = [gregorian dateFromComponents:startOfNextYearComponents];
    
    double decimalYear = [dateComponents year] + ([self timeIntervalSinceDate:startOfYear]/[startOfNextYear timeIntervalSinceDate:startOfYear]);
    
    return decimalYear;
}

@end
