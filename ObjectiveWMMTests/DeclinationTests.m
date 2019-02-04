//
//  DeclinationTests.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 12/15/14.
//  Copyright (c) 2014 Crookneck Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ObjectiveWMM/ObjectiveWMM.h>

@interface DeclinationTests : XCTestCase

@property (nonatomic, strong) NSCalendar *gregorian;

@end

@implementation DeclinationTests

- (NSCalendar *) gregorian {
    
    if (nil == _gregorian) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _gregorian;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // run tests in GMT, overriding local system time zone
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Etc/GMT"]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCoefficientFileFound {
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.crookneckconsulting.ObjectiveWMM"];
    NSString *path = [bundle pathForResource:@"WMM" ofType:@"COF"];
    XCTAssertNotNil(path, @"Path to WMM.COF was nil");
}

- (void) testModelValidityPeriod {
    
    // Current model is valid from 2015 through 2020 (see http://www.ngdc.noaa.gov/geomag/WMM/soft.shtml)
    
    NSDate *validFrom = [self dateForYear:2015 month:1 day:1];
    NSDate *validTo = [self dateForYear:2020 month:12 day:31];
    
    XCTAssertTrue([validFrom isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected model validity start date");
    XCTAssertTrue([validTo isEqualToDate:[[CCMagneticModel instance] modelValidityEnd]], @"Unexpected model validity end date");
}

// See http://www.ngdc.noaa.gov/geomag/WMM/data/WMM2015/WMM2015testvalues.pdf for tests 01 through 12

- (void) testDeclination01 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, -3.90, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination02 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 0.55, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination03 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 69.81, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination04 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, -4.32, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination05 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 0.54, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination06 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 69.22, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination07 {
    
    NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, -2.59, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination08 {
    
    NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 0.37, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination09 {
    
    NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 69.59, 0.006, @"Unexpected declination");
    
}

- (void) testDeclination10 {
    
    NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, -3.01, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination11 {
    
    NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 0.36, 0.005, @"Unexpected declination");
    
}

- (void) testDeclination12 {
    
    NSDate *date = [self dateForYear:2017 month:7 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:100000 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 69.01, 0.005, @"Unexpected declination");
    
}

// Subsequent test values obtained from http://www.ngdc.noaa.gov/geomag-web/#igrfwmm with model set to WMM2015
// 4 Feb 2019: expected results updated from http://www.ngdc.noaa.gov/geomag-web/#igrfwmm - although not stated, this online calculator appears to have been updated to use WMM2015v2 COF

- (void) testDeclination13 {
    
    // Boulder, Colorado on Jan 10 2018
    
    NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 8.4116, 0.001, @"Unexpected declination");
    
}

- (void) testDeclination14 {
    
    // London, UK on Aug 28 2019
    
    NSDate *date = [self dateForYear:2019 month:8 day:28];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(51.507335, -0.127683);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:22.0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, -0.0432, 0.002, @"Unexpected declination");
    
}

- (void) testDeclination15 {
    
    // Sydney, Australia on Dec 31 2014
    
    NSDate *date = [self dateForYear:2019 month:12 day:31];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy(declination.magneticDeclination, 12.5805, 0.003, @"Unexpected declination");
}

- (void) testInvalidDate01 {
    
    // Sydney, Australia on Jan 1 2021 - date is out of model bounds, declination returned should equal zero
    
    NSDate *date = [self dateForYear:2021 month:1 day:1];
    
    XCTAssertFalse([[CCMagneticModel instance] dateIsWithinModelBounds:date], @"Expected date to be out of model bounds");
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    XCTAssertNil(declination, @"Declination should be nil");
    
}

- (void) testInvalidDate02 {
    
    // Sydney, Australia on Dec 31 2014 - date is out of model bounds, declination returned should equal zero
    
    NSDate *date = [self dateForYear:2014 month:12 day:31];
    
    XCTAssertFalse([[CCMagneticModel instance] dateIsWithinModelBounds:date], @"Expected date to be out of model bounds");
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-33.867487, 151.206990);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:54.0 date:date];
    XCTAssertNil(declination, @"Declination should be nil");
}

- (void) testTrueHeading01 {
    
    // Boulder, Colorado on Jan 10 2018
    
    NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy([declination trueHeadingFromMagneticHeading:94.0], 94.0 + 8.4116, 0.001, @"Unexpected true heading");
    
}

- (void) testMagneticHeading01 {
    
    // Boulder, Colorado on Jan 10 2018
    
    NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    
    NSLog(@"declination = %f", declination.magneticDeclination);
    XCTAssertEqualWithAccuracy([declination magneticHeadingFromTrueHeading:94.0 + 8.4116], 94.0, 0.001, @"Unexpected magnetic heading");
    
}

- (void) testDateBounds01 {
    
    NSDate *date = [self dateForYear:2014 month:8 day:1];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    XCTAssertTrue([withinBounds isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected date");
}

- (void) testDateBounds02 {
    
    NSDate *date = [self dateForYear:2022 month:3 day:21];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    
    XCTAssertEqualObjects(date, [withinBounds laterDate:date], @"Unexpected date");
}

- (void) testDateBounds03 {
    
    NSDate *date = [self dateForYear:2018 month:6 day:21];
    
    NSDate *withinBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:date];
    
    XCTAssertTrue([withinBounds isEqualToDate:date], @"Unexpected date");
}

- (void) testDateWithinBounds01 {
    
    NSDate *inputDate = [self dateForYear:2022 month:1 day:1]; // out of range
    
    NSDate *dateInBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:inputDate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    XCTAssertNotNil([[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630 date:dateInBounds], @"Declination was nil");
}

- (void) testDateWithinBounds02 {
    
    NSDate *inputDate = [self dateForYear:2015 month:1 day:1]; // out of range
    
    NSDate *dateInBounds = [[CCMagneticModel instance] dateWithinModelBoundsFromDate:inputDate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    XCTAssertNotNil([[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630 date:dateInBounds], @"Declination was nil");
}

- (void) testHeadingInBounds01 {
    
    // New York on Jan 10 2018
    
    NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.714353, -74.005973);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:57.0 date:date];
    double heading = [declination trueHeadingFromMagneticHeading:0.0];
    
    NSLog(@"heading = %f", heading);
    XCTAssertTrue(0 < heading, @"heading was less than zero");
    XCTAssertTrue(heading < 360, @"heading was greater than 360");
    
}

- (void) testHeadingInBounds02 {
    
    // Boulder, Colorado on Jan 10 2018
    
    NSDate *date = [self dateForYear:2018 month:1 day:10];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.014986, -105.270546);
    
    CCMagneticDeclination *declination = [[CCMagneticModel instance] declinationForCoordinate:coord elevation:1630.0 date:date];
    double heading = [declination magneticHeadingFromTrueHeading:0.0];
    
    NSLog(@"heading = %f", heading);
    XCTAssertTrue(0 < heading, @"heading was less than zero");
    XCTAssertTrue(heading < 360, @"heading was greater than 360");
    
}

#pragma mark - Helper methods

- (NSDate *) dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    static NSDateComponents *comps;
    if (nil == comps) {
        comps = [[NSDateComponents alloc] init];
    }
    
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSDate *date = [self.gregorian dateFromComponents:comps];
    
    return date;
}

@end
