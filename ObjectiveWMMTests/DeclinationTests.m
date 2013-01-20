//
//  DeclinationTests.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "CCMagneticModel.h"
#import "CCMagneticDeclination.h"

@interface DeclinationTests : GHTestCase { }

- (NSDate *) dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

@implementation DeclinationTests

- (void) setUpClass {
    
    // run tests in GMT, overriding local system time zone
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Etc/GMT"]];
}

- (void) testModelValidityPeriod {
    
    // Current model is valid from 2010 through 2015 (see http://www.ngdc.noaa.gov/geomag/WMM/soft.shtml)
    
    NSDate *validFrom = [self dateForYear:2010 month:1 day:1];
    NSDate *validTo = [self dateForYear:2015 month:12 day:31];
    
    GHAssertTrue([validFrom isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected model validity start date");
    GHAssertTrue([validTo isEqualToDate:[[CCMagneticModel instance] modelValidityEnd]], @"Unexpected model validity end date");
}

// See http://www.ngdc.noaa.gov/geomag/WMM/data/WMM2010/WMM2010testvalues.pdf for tests 01 through 12

- (void) testDeclination01 {
    
	NSDate *date = [self dateForYear:2010 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];

    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -6.13, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination02 {
    
	NSDate *date = [self dateForYear:2010 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.97, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination03 {
    
	NSDate *date = [self dateForYear:2010 month:1 day:1];	
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 70.21, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination04 {
    
    NSDate *date = [self dateForYear:2010 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -6.57, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination05 {
    
	NSDate *date = [self dateForYear:2010 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.94, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination06 {
    
	NSDate *date = [self dateForYear:2010 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 69.62, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination07 {
    
	NSDate *date = [self dateForYear:2012 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -5.21, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination08 {
    
	NSDate *date = [self dateForYear:2012 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.88, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination09 {
    
	NSDate *date = [self dateForYear:2012 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 70.04, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination10 {
    
	NSDate *date = [self dateForYear:2012 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -5.63, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination11 {
    
	NSDate *date = [self dateForYear:2012 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.86, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination12 {
    
	NSDate *date = [self dateForYear:2012 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 69.45, 0.005, @"Unexpected declination");
    
}

// Subsequent test values obtained from http://www.ngdc.noaa.gov/geomag-web/#igrfwmm with model set to WMM2010

- (void) testDeclination13 {
    
    // Boulder, Colorado on Jan 10 2013
    
	NSDate *date = [self dateForYear:2013 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 8.88428, 0.00005, @"Unexpected declination");
    
}

- (void) testDeclination14 {
    
    // London, UK on Aug 28 2014
    
	NSDate *date = [self dateForYear:2014 month:8 day:28];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(51.507335, -0.127683);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:22.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -1.04029, 0.00005, @"Unexpected declination");
    
}

- (void) testDeclination15 {
    
    // Sydney, Australia on Dec 31 2014
    
	NSDate *date = [self dateForYear:2014 month:12 day:31];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 12.50009, 0.00005, @"Unexpected declination");
}

- (void) testInvalidDate01 {
    
    // Sydney, Australia on Jan 1 2016 - date is out of model bounds, declination returned should equal zero
    
	NSDate *date = [self dateForYear:2016 month:1 day:1];
    
    GHAssertFalse([[CCMagneticModel instance] dateIsWithinModelBounds:date], @"Expected date to be out of model bounds");
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    GHAssertNil(declination, @"Declination should be nil");

}

- (void) testInvalidDate02 {
    
    // Sydney, Australia on Dec 31 2009 - date is out of model bounds, declination returned should equal zero
    
	NSDate *date = [self dateForYear:2009 month:12 day:31];
    
    GHAssertFalse([[CCMagneticModel instance] dateIsWithinModelBounds:date], @"Expected date to be out of model bounds");
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    GHAssertNil(declination, @"Declination should be nil");
}

- (void) testTrueHeading01 {
    
    // Boulder, Colorado on Jan 10 2013
    
	NSDate *date = [self dateForYear:2013 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy([declination trueHeadingFromMagneticHeading:94.0], 94.0 + 8.88428, 0.00005, @"Unexpected true heading");

}

- (void) testMagneticHeading01 {
    
    // Boulder, Colorado on Jan 10 2013
    
	NSDate *date = [self dateForYear:2013 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy([declination magneticHeadingFromTrueHeading:94.0 + 8.88428], 94.0, 0.00005, @"Unexpected magnetic heading");
    
}

- (void) testDateBounds01 {
    
    NSDate *date = [self dateForYear:2009 month:8 day:1];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    GHAssertTrue([withinBounds isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected date");
}

- (void) testDateBounds02 {
    
    NSDate *date = [self dateForYear:2017 month:3 day:21];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    GHAssertEqualObjects(date, [withinBounds laterDate:date], @"Unexpected date");
}

- (void) testDateBounds03 {
    
    NSDate *date = [self dateForYear:2013 month:6 day:21];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    GHAssertTrue([withinBounds isEqualToDate:date], @"Unexpected date");
}

- (void) testDateWithinBounds01 {
    
    NSDate *inputDate = [self dateForYear:2017 month:1 day:1]; // out of range
    
    NSDate *dateInBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:inputDate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    GHAssertNotNil([[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630 date:dateInBounds], @"Declination was nil");
}

- (void) testDateWithinBounds02 {
    
    NSDate *inputDate = [self dateForYear:2010 month:1 day:1]; // out of range
    
    NSDate *dateInBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:inputDate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    GHAssertNotNil([[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630 date:dateInBounds], @"Declination was nil");
}

#pragma mark - Helper methods

- (NSDate *) dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:day];
	[comps setMonth:month];
	[comps setYear:year];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *date = [gregorian dateFromComponents:comps];

    return date;
}

@end