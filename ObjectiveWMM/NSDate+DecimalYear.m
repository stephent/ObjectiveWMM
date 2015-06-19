//
//  NSDate+DecimalYear.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import "NSDate+DecimalYear.h"

@implementation NSDate (DecimalYear)

- (NSDecimalNumber *) decimalYear {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
                                                              | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
	
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
    
    NSDecimalNumber *y = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:[dateComponents year]] decimalValue]];
    NSDecimalNumber *d1 = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:[self timeIntervalSinceDate:startOfYear]] decimalValue]];
    NSDecimalNumber *d2 = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:[startOfNextYear timeIntervalSinceDate:startOfYear]] decimalValue]];
    
    NSDecimalNumber *result = [y decimalNumberByAdding:[d1 decimalNumberByDividingBy:d2]];
    
    //double decimalYear = [dateComponents year] + (double) ([self timeIntervalSinceDate:startOfYear]/[startOfNextYear timeIntervalSinceDate:startOfYear]);
    
    return result;
}

@end
