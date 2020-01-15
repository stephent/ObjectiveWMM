ObjectiveWMM
============

An Objective-C iOS wrapper for the [World Magnetic Model 2020](https://www.ngdc.noaa.gov/geomag/WMM/DoDWMM.shtml).

ObjectiveWMM is a simple repackaging for iOS of the C-language World Magnetic Model published by the United States’ National Geospatial-Intelligence Agency (NGA) and the United Kingdom’s Defence Geographic Centre (DGC).

WMM is primarily useful to be able to determine the magnetic declination for a given location on a given date. As the earth's magnetic field changes over time, the model provides a way to obtain a predicted value for magnetic declination.

Magnetic declination is required in order to convert between headings relative to true north and magnetic north. The difference can be significant in certain parts of the world.

## Limitations of CoreLocation

I suspect that iOS already has the World Magnetic Model built in to the system software. `CLHeading` provides both `magneticHeading` and `trueHeading` properties, where the difference between the values represents the magneticDeclination. However, per Apple's documentation:

>Typically, you do not create instances of this class yourself, nor do you subclass it. Instead, you receive instances of this class through the delegate assigned to the CLLocationManager object whose startUpdatingHeading method you called.

The consequence of that is that via CoreLocation, you can only determine magneticDeclination for here (where the device is actually located) and now (the moment you retrieve the `CLHeading` object).

## Intended use cases

Mapping, route-finding and astronomical applications may wish to include magnetic headings for users making use of a magnetic compass in the field. The headings may pertain to places other than the current device location and for dates in the future (or the past).

In order to obtain, for example, a magnetic heading from a heading relative to true north, ObjectiveWMM can provide the magnetic declination required to make the correction.

## Getting Started

* Download [ObjectiveWMM](https://github.com/stephent/ObjectiveWMM/archive/master.zip) and open the project in Xcode.
* Choose the ObjectiveWMM Target and an iOS Simulator
* Run the selected target and execute the unit tests

The project is configured as a Dynamic Framework targeting iOS 8.1. The unit tests (using XCTest) demonstrate how to use the classes in the project.

## What's included

ObjectiveWMM includes a copy of the required source files from the original WMM2015 Linux C-language distribution (available [here](http://www.ngdc.noaa.gov/geomag/WMM/soft.shtml)).

Three additional classes are provided to provide a convenient interface for iOS Objective-C projects:

* `CCMagneticModel` - a singleton class that initializes the WMM model
* `CCMagneticDeclination` - a result object that holds the calculated magnetic declination for a given coordinate, elevation and date
* `NSDate+DecimalYear` - a category on NSDate to provide decimal date values required as inputs into WMM

CCMagneticDeclination could optionally be subclassed and extended to return additional model results obtained from the `MAGtype_GeoMagneticElements` struct. (At present, these results are not included as they have more specialized application than the magnetic declination.)

The ObjectiveWMM target in the project consists of an empty iOS application. This may be extended in the future. For the time being, the unit tests are your best guide.

## Test cases

The project includes a number of unit tests that utilize the [WMM2020 Test Values](https://www.ngdc.noaa.gov/geomag/WMM/data/WMM2020/WMM2020testvalues.pdf) provided by the original model authors.

In addition, a small number of test cases have been added, with test results taken from the DoD World Magnetic Model [Single Point Calculator](http://www.ngdc.noaa.gov/geomag-web/#igrfwmm) (2020 - 2025), configured to use  WMM (2019-2024).

Finally, tests are included to validate model boundary dates. WMM 2020 is intended for use with dates falling in the years 2020-2025 only.

## Modifications to WMM source

Only two minor changes have been made to the WMM source code included with this project. In the file GeomagnetismHeader.h, 

	#define TRUE            ((int)1)
	#define FALSE           ((int)0)

was changed to:

	#ifndef TRUE
	#define TRUE            ((int)1)
	#endif

	#ifndef FALSE
	#define FALSE           ((int)0)
	#endif

in order to avoid compiler warnings about redefining TRUE and FALSE.

## Credits

The World Magnetic Model is a joint product of the United States’ National Geospatial-Intelligence Agency (NGA) and the United Kingdom’s Defence Geographic Centre (DGC). The WMM was developed jointly by the National Geophysical Data Center (NGDC, Boulder CO, USA) and the British Geological Survey (BGS, Edinburgh, Scotland).

ObjectiveWMM by [stephentrainor](https://github.com/stephent/).

## License

ObjectiveWMM includes portions of the WMM source code distributed by NCEI.

The WMM source code is in the public domain and not licensed or under copyright. The information and software may be used freely by the public. As required by 17 U.S.C. 403, third parties producing copyrighted works consisting predominantly of the material produced by U.S. government agencies must provide notice with such work(s) identifying the U.S. Government material incorporated and stating that such material is not subject to copyright protection.

The remaining source code in ObjectiveWMM is available under the MIT license. See the LICENSE file for more info.


