//
//  CCMagneticDeclination.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import "CCMagneticDeclination.h"

@interface CCMagneticDeclination()

@property (readwrite, nonatomic) CLLocationCoordinate2D coordinate;
@property (readwrite, nonatomic) CLLocationDistance elevation;
@property (readwrite, nonatomic, strong) NSDate *date;
@property (readwrite, nonatomic) CLLocationDirection magneticDeclination;

@end

@implementation CCMagneticDeclination

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate elevation:(CLLocationDistance)elevation date:(NSDate *)date magneticDeclination:(CLLocationDirection)magneticDeclination {
    
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.elevation = elevation;
        self.date = date;
        self.magneticDeclination = magneticDeclination;
    }
    
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    
    CCMagneticDeclination *magneticDeclination = [[CCMagneticDeclination allocWithZone:zone] initWithCoordinate:self.coordinate elevation:self.elevation date:self.date magneticDeclination:self.magneticDeclination];
    
    return magneticDeclination;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([aDecoder decodeDoubleForKey:@"latitude"], [aDecoder decodeDoubleForKey:@"longitude"]);
    CLLocationDistance elevation = [aDecoder decodeDoubleForKey:@"elevation"];
    NSDate *date = [aDecoder decodeObjectForKey:@"date"];
    CLLocationDirection magneticDeclination = [aDecoder decodeDoubleForKey:@"magneticDeclination"];
    
    self = [self initWithCoordinate:coord elevation:elevation date:date magneticDeclination:magneticDeclination];
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
}

#pragma mark - Public

- (CLLocationDirection) trueHeadingFromMagneticHeading:(CLLocationDirection)magneticHeading {
    
    return magneticHeading + self.magneticDeclination;
}

- (CLLocationDirection) magneticHeadingFromTrueHeading:(CLLocationDirection)trueHeading {
    
    return trueHeading - self.magneticDeclination;
}

@end
