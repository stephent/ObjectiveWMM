//
//  CCMagneticDeclination.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//
//  
//
//  Adapted from WMM Linux source code found here: http://www.ngdc.noaa.gov/geomag/WMM/soft.shtml
//  See wmm_point.c for sample of how to obtain geoMagneticElements for a given coordinate, elevation and date
//  This class implements exposes the same functionality through an Objective-C singleton class for iOS in order to obtain
//  the magnetic declination for an arbitrary coordinate.

#import "CCMagneticModel.h"

#import "GeomagnetismHeader.h"
#import "EGM9615.h"

#import "NSDate+DecimalYear.h"

// courtesy of http://stackoverflow.com/questions/8650465/including-libraries-that-need-external-files-in-ios-project#comment10747339_8650503
const char * getPathForResource(const char *fileName, const char *fileExtension) {
    
    NSString *fn = [NSString stringWithCString:fileName encoding:NSUTF8StringEncoding];
    NSString *fe = [NSString stringWithCString:fileExtension encoding:NSUTF8StringEncoding];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fn ofType:fe];
    
    return [path cStringUsingEncoding:NSUTF8StringEncoding];
}

@interface CCMagneticModel()

- (BOOL) decimalYearIsWithinModelBounds:(NSDecimalNumber *)decimalYear;
- (NSDate *) dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

@implementation CCMagneticModel {
    
    MAGtype_MagneticModel * _magneticModels[1], * _timedMagneticModel;
    MAGtype_Ellipsoid _ellip;
    MAGtype_Geoid _geoid;
    
    NSDecimalNumberHandler *_decimalHandler;
}

+ (CCMagneticModel *) instance {
    static CCMagneticModel *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CCMagneticModel alloc] init];
    });
    
    return _instance;
}

- (id) init {
    
    self = [super init];
    if (self) {
        
        int epochs = 1;
        int numTerms, nMax = 0;
        
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.crookneckconsulting.ObjectiveWMM"];
        NSString *path = [bundle pathForResource:@"WMM" ofType:@"COF"];
        
        char *filename = (char *) [path cStringUsingEncoding:NSUTF8StringEncoding];
        
        MAG_robustReadMagModels(filename, &_magneticModels, epochs);
        
        if (nMax < _magneticModels[0]->nMax)
            nMax = _magneticModels[0]->nMax;
        
        numTerms = ((nMax + 1) * (nMax + 2) / 2);

        _timedMagneticModel = MAG_AllocateModelMemory(numTerms); /* For storing the time modified WMM Model parameters */
        
        if (_magneticModels[0] == NULL || _timedMagneticModel == NULL) {
            //MAG_Error(2);
        }
        
        MAG_SetDefaults(&_ellip, &_geoid); /* Set default values and constants */
        
        /* Set EGM96 Geoid parameters */
        _geoid.GeoidHeightBuffer = GeoidHeightBuffer;
        _geoid.Geoid_Initialized = 1;
        /* Set EGM96 Geoid parameters END */
        
        // get a decimal number handler to allow us to round down decimal year values when testing dates in model bounds
        _decimalHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    }
    
    return self;
}

- (void) dealloc {
    
    MAG_FreeMagneticModelMemory(_timedMagneticModel);
    MAG_FreeMagneticModelMemory(_magneticModels[0]);
}

+(CLLocationDirection) declinationForLocation:(CLLocation *) location {
    CCMagneticModel *instance = [CCMagneticModel instance];
    CCMagneticDeclination *declination = [instance declinationForCoordinate:location.coordinate elevation:location.altitude date:location.timestamp];
    return declination.magneticDeclination;
}

- (CCMagneticDeclination *) declinationForCoordinate:(CLLocationCoordinate2D)coordinate elevation:(CLLocationDistance)elevation date:(NSDate *)date {
    
    MAGtype_CoordSpherical coordSpherical;
    MAGtype_Date userDate;
    
    MAGtype_CoordGeodetic coordGeodetic;
    MAGtype_GeoMagneticElements geoMagneticElements;

    // geodetic coordinates
    coordGeodetic.phi = coordinate.latitude;
    coordGeodetic.lambda = coordinate.longitude;
    coordGeodetic.HeightAboveEllipsoid = elevation/1000.0; // convert to km from metres
    coordGeodetic.HeightAboveGeoid = 0;
    coordGeodetic.UseGeoid = 0;
    
    // date of interest
    NSDecimalNumber *decimalYear = [date decimalYear];
    userDate.DecimalYear = decimalYear.doubleValue;
    
    if (YES == [self decimalYearIsWithinModelBounds:decimalYear]) {
        // Convert from geodetic to Spherical Equations: 17-18, WMM Technical report
        MAG_GeodeticToSpherical(_ellip, coordGeodetic, &coordSpherical);
        
        // Time adjust the coefficients, Equation 19, WMM Technical report
        MAG_TimelyModifyMagneticModel(userDate, _magneticModels[0], _timedMagneticModel);
        
        // Computes the geoMagnetic field elements and their time change
        MAG_Geomag(_ellip, coordSpherical, coordGeodetic, _timedMagneticModel, &geoMagneticElements);
        
        MAG_CalculateGridVariation(coordGeodetic, &geoMagneticElements);
        
        CCMagneticDeclination *result = [[CCMagneticDeclination alloc] initWithCoordinate:coordinate elevation:elevation date:date magneticDeclination:geoMagneticElements.Decl fieldStrength:geoMagneticElements.F/1000.0];
        
        return result;
    }
    
    // date was out of model bounds
    return nil;
}

- (BOOL) dateIsWithinModelBounds:(NSDate *) date {
    
    return [self decimalYearIsWithinModelBounds:[date decimalYear]];
}

- (NSDate *) modelValidityStart {
    
    NSDate *validFrom = [self dateForYear: _magneticModels[0]->epoch month:1 day:1];
    
    return validFrom;
}

- (NSDate *) modelValidityEnd {
    
    NSDate *validTo = [self dateForYear:_magneticModels[0]->CoefficientFileEndDate month:12 day:31];
    
    return validTo;
}

- (NSDate *) dateWithinModelBoundsFromDate:(NSDate *)date {
    
    NSDate *modelStart = [self modelValidityStart];
    if (date == [date earlierDate:modelStart])
        return modelStart;
    
    // one second before model expiry, so that the floor of modelEnd.decimal year equals preceding year
    // (see decimalYearIsWithinModelBounds:)
    NSDate *modelEnd = [[self modelValidityEnd] dateByAddingTimeInterval:-1];
    if (date == [date laterDate:modelEnd]) {
        return modelEnd;
    }
    
    return date;
}

#pragma mark - Private helper methods

- (BOOL) decimalYearIsWithinModelBounds:(NSDecimalNumber *)decimalYear {
 
    double year = [decimalYear decimalNumberByRoundingAccordingToBehavior:_decimalHandler].doubleValue;
    if(year > _magneticModels[0]->CoefficientFileEndDate || year < _magneticModels[0]->epoch) {
        return NO;
    }

    return YES;
}

- (NSDate *) dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:day];
	[comps setMonth:month];
	[comps setYear:year];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDate *date = [gregorian dateFromComponents:comps];
    
    return date;
}

@end
