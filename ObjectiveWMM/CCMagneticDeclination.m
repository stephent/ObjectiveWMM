//
//  CCMagneticDeclination.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import "CCMagneticDeclination.h"

static inline double withinZeroTo360(double degrees) {
    return (degrees - (360.0 * floor(degrees/360.0)));
}

@interface CCMagneticDeclination()

@property (readwrite, nonatomic) CLLocationCoordinate2D coordinate;
@property (readwrite, nonatomic) CLLocationDistance elevation;
@property (readwrite, nonatomic, strong) NSDate *date;
@property (readwrite, nonatomic) CLLocationDirection magneticDeclination;
@property (readwrite, nonatomic) double fieldStrength;

@end

@implementation CCMagneticDeclination

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate elevation:(CLLocationDistance)elevation date:(NSDate *)date magneticDeclination:(CLLocationDirection)magneticDeclination  fieldStrength:(double)fieldStrength {
    
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _elevation = elevation;
        _date = date;
        _magneticDeclination = magneticDeclination;
        _fieldStrength = fieldStrength;
    }
    
    return self;
}

- (NSString *) description {
    
    NSString *desc = [NSString stringWithFormat:@"%1.3f°,%1.3f° / %1.2fm at %@: decl: %1.2f° F: %1.2fμT", self.coordinate.latitude, self.coordinate.longitude, self.elevation, self.date.description, self.magneticDeclination, self.fieldStrength];
    
    return desc;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    
    CCMagneticDeclination *magneticDeclination = [[CCMagneticDeclination allocWithZone:zone] initWithCoordinate:self.coordinate elevation:self.elevation date:self.date magneticDeclination:self.magneticDeclination fieldStrength:self.fieldStrength];
    
    return magneticDeclination;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([aDecoder decodeDoubleForKey:@"latitude"], [aDecoder decodeDoubleForKey:@"longitude"]);
    CLLocationDistance elevation = [aDecoder decodeDoubleForKey:@"elevation"];
    NSDate *date = [aDecoder decodeObjectForKey:@"date"];
    CLLocationDirection magneticDeclination = [aDecoder decodeDoubleForKey:@"magneticDeclination"];
    double fieldStrength = [aDecoder decodeDoubleForKey:@"fieldStrength"];
    
    self = [self initWithCoordinate:coord elevation:elevation date:date magneticDeclination:magneticDeclination fieldStrength:fieldStrength];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeDouble:self.coordinate.latitude forKey:@"latitude"];
    [aCoder encodeDouble:self.coordinate.longitude forKey:@"longitude"];
    [aCoder encodeDouble:self.elevation forKey:@"elevation"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeDouble:self.magneticDeclination forKey:@"magneticDeclination"];
    [aCoder encodeDouble:self.fieldStrength forKey:@"fieldStrength"];
}

#pragma mark - Public

- (CLLocationDirection) trueHeadingFromMagneticHeading:(CLLocationDirection)magneticHeading {
    
    return withinZeroTo360(magneticHeading + self.magneticDeclination);
}

- (CLLocationDirection) magneticHeadingFromTrueHeading:(CLLocationDirection)trueHeading {
    
    return withinZeroTo360(trueHeading - self.magneticDeclination);
}

@end
