//
//  CCMagneticDeclination.h
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CCMagneticDeclination : NSObject <NSCopying, NSCoding>

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate elevation:(CLLocationDistance)elevation date:(NSDate *)date magneticDeclination:(CLLocationDirection)magneticDeclination fieldStrength:(double)fieldStrength;

@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, nonatomic) CLLocationDistance elevation;
@property (readonly, nonatomic, strong) NSDate *date;
@property (readonly, nonatomic) CLLocationDirection magneticDeclination;
@property (readonly, nonatomic) double fieldStrength; // in μT

- (CLLocationDirection) trueHeadingFromMagneticHeading:(CLLocationDirection)magneticHeading;
- (CLLocationDirection) magneticHeadingFromTrueHeading:(CLLocationDirection)trueHeading;

@end
