ObjectiveWMM
============

An Objective-C iOS wrapper for the World Magnetic Model 2010.

ObjectiveWMM is a simple repackaging for iOS of the C-language World Magnetic Model published by the United States’ National Geospatial-Intelligence Agency (NGA) and the United Kingdom’s Defence Geographic Centre (DGC).

WMM is primarily useful to be able to determine the magnetic declination for a given location on a given date. As the earth's magnetic field changes over time, the model provides a way to obtain a predicated value for magnetic declination.

Magnetic declination is required in order to convert between headings relative to true north and magnetic north. The difference can be very significant in certain parts of the world.

## Limitations of CoreLocation

I suspect that iOS already has the World Magnetic Model built in to the system software. `CLHeading` provides both `magneticHeading` and `trueHeading` properties, where the difference between the values represents the magneticDeclination. However, per Apple's documentation:

>Typically, you do not create instances of this class yourself, nor do you subclass it. Instead, you receive instances of this class through the delegate assigned to the CLLocationManager object whose startUpdatingHeading method you called.

The consequence of that is that via CoreLocation, you can only determine magneticDeclination for here (where the device is actually located) and now (the moment you retrieve the `CLHeading` object).

## Intended use cases

Mapping, route-finding and astronomical applications may wish to include magnetic headings for users making use of a magnetic compass in the field. The headings may pertain to places other than the current device location and for dates in the future (or the past).

In order to obtain, for example, a magnetic heading from a heading relative to true north, ObjectiveWMM can provide the magnetic declination required to make the correction.


