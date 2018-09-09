//
//  File.swift
//  
//
//  Created by Dan Lages on 09/09/2018.
//

import Foundation
import CoreLocation
import Mapkit


//To be placed in View Did Load
locationManager.delegate = self //CLLocationManager Delegate
locationManager.requestLocation()
locationManager.requestWhenInUseAuthorization() //Only require information when app is in the forground
locationManager.startUpdatingLocation()
locationManager.distanceFilter = 100 //Only update distance information when user has moved given number of meters from previous update to improve efficiency

//Location Function
let locationManager = CLLocationManager() //Define Location manager object.

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //Delegate function allows us to handle loaction information
    let location:CLLocationCoordinate2D = manager.location!.coordinate //Determine user location
    let userLat = location.latitude
    let userLong = location.longitude
    let userLocation = CLLocation(latitude: userLat, longitude: userLong)
    
    //Convert data to readable 2D coordinate region
    let span = MKCoordinateSpanMake(0.01, 0.01)
    let currentLocal = userLocation.coordinate
    let region = MKCoordinateRegionMake(currentLocal, span)
    
    destinationMapView.setRegion(region, animated: true) // Represent User Location on map
    self.destinationMapView.showsUserLocation = true
    
    let geoCoder = CLGeocoder()
    for dest in destinations {
        // Determine location of each destination displayed in table view
        let destinationAddress = (dest.addressNo + ", " + dest.addressStreet + ", " + dest.addressPostcode) //Group address variables to analyse the geo-location
        geoCoder.geocodeAddressString(destinationAddress) {
            placemarks, error in
            let placemark = placemarks?.first
            
            let destLat = placemark?.location?.coordinate.latitude
            let destLong = placemark?.location?.coordinate.longitude
            let destCoordinates = CLLocation(latitude: destLat!, longitude: destLong!) //Determine at set lat and long coordinates
            let distance = String(format: "%2f km", destCoordinates.distance(from: userLocation) / 1000)
            
            print ("Distance in KM is: \(distance)")
        }
        //Filter table based on closest location
    }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
}
