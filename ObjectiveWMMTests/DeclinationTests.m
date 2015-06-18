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
    
    // Current model is valid from 2015 through 2020 (see http://www.ngdc.noaa.gov/geomag/WMM/soft.shtml)
    
    NSDate *validFrom = [self dateForYear:2015 month:1 day:1];
    NSDate *validTo = [self dateForYear:2020 month:12 day:31];
    
    GHAssertTrue([validFrom isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected model validity start date");
    GHAssertTrue([validTo isEqualToDate:[[CCMagneticModel instance] modelValidityEnd]], @"Unexpected model validity end date");
}

// See http://www.ngdc.noaa.gov/geomag/WMM/data/WMM2015/WMM2015testvalues.pdf for tests 01 through 12

- (void) testDeclination01 {
    
	NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];

    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -3.85, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination02 {
    
	NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.57, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination03 {
    
	NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 69.81, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination04 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -4.27, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination05 {
    
	NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.56, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination06 {
    
	NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 69.22, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination07 {
    
	NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -2.75, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination08 {
    
	NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.32, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination09 {
    
	NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 69.58, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination10 {
    
	NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -3.17, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination11 {
    
	NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 0.32, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination12 {
    
	NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 69.00, 0.005, @"Unexpected declination");
    
}

// Subsequent test values obtained from http://www.ngdc.noaa.gov/geomag-web/#igrfwmm with model set to WMM2015

- (void) testDeclination13 {
    
    // Boulder, Colorado on Jan 10 2018
    
	NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 8.37904, 0.00005, @"Unexpected declination");
    
}

- (void) testDeclination14 {
    
    // London, UK on Aug 28 2019
    
	NSDate *date = [self dateForYear:2019 month:8 day:28];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(51.507335, -0.127683);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:22.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, -0.19978, 0.00005, @"Unexpected declination");
    
}

- (void) testDeclination15 {
    
    // Sydney, Australia on Dec 31 2014
    
	NSDate *date = [self dateForYear:2019 month:12 day:31];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy(declination.magneticDeclination, 12.60236, 0.00005, @"Unexpected declination");
}

- (void) testInvalidDate01 {
    
    // Sydney, Australia on Jan 1 2021 - date is out of model bounds, declination returned should equal zero
    
	NSDate *date = [self dateForYear:2021 month:1 day:1];
    
    GHAssertFalse([[CCMagneticModel instance] dateIsWithinModelBounds:date], @"Expected date to be out of model bounds");
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    GHAssertNil(declination, @"Declination should be nil");

}

- (void) testInvalidDate02 {
    
    // Sydney, Australia on Dec 31 2014 - date is out of model bounds, declination returned should equal zero
    
	NSDate *date = [self dateForYear:2014 month:12 day:31];
    
    GHAssertFalse([[CCMagneticModel instance] dateIsWithinModelBounds:date], @"Expected date to be out of model bounds");
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    GHAssertNil(declination, @"Declination should be nil");
}

- (void) testTrueHeading01 {
    
    // Boulder, Colorado on Jan 10 2018
    
	NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy([declination trueHeadingFromMagneticHeading:94.0], 94.0 + 8.37904, 0.00005, @"Unexpected true heading");

}

- (void) testMagneticHeading01 {
    
    // Boulder, Colorado on Jan 10 2018
    
	NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    GHTestLog(@"declination = %f", declination.magneticDeclination);
    GHAssertEqualsWithAccuracy([declination magneticHeadingFromTrueHeading:94.0 + 8.37904], 94.0, 0.00005, @"Unexpected magnetic heading");
    
}

- (void) testDateBounds01 {
    
    NSDate *date = [self dateForYear:2014 month:8 day:1];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    GHAssertTrue([withinBounds isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected date");
}

- (void) testDateBounds02 {
    
    NSDate *date = [self dateForYear:2022 month:3 day:21];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    GHAssertEqualObjects(date, [withinBounds laterDate:date], @"Unexpected date");
}

- (void) testDateBounds03 {
    
    NSDate *date = [self dateForYear:2018 month:6 day:21];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    GHAssertTrue([withinBounds isEqualToDate:date], @"Unexpected date");
}

- (void) testDateWithinBounds01 {
    
    NSDate *inputDate = [self dateForYear:2022 month:1 day:1]; // out of range
    
    NSDate *dateInBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:inputDate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    GHAssertNotNil([[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630 date:dateInBounds], @"Declination was nil");
}

- (void) testDateWithinBounds02 {
    
    NSDate *inputDate = [self dateForYear:2015 month:1 day:1]; // out of range
    
    NSDate *dateInBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:inputDate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    GHAssertNotNil([[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630 date:dateInBounds], @"Declination was nil");
}

- (void) testHeadingInBounds01 {
        
    // New York on Jan 10 2018
    
	NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.714353, -74.005973);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:57.0 date:date];
    double heading = [declination trueHeadingFromMagneticHeading:0.0];
    
    GHTestLog(@"heading = %f", heading);
    GHAssertTrue(0 < heading, @"heading was less than zero");
    GHAssertTrue(heading < 360, @"heading was greater than 360");

}

- (void) testHeadingInBounds02 {
    
    // Boulder, Colorado on Jan 10 2018
    
	NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    double heading = [declination magneticHeadingFromTrueHeading:0.0];
    
    GHTestLog(@"heading = %f", heading);
    GHAssertTrue(0 < heading, @"heading was less than zero");
    GHAssertTrue(heading < 360, @"heading was greater than 360");
    
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