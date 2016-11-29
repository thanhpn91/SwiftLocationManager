// Copyright (c) 2016 Thanh Pham
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import CoreLocation
import UIKit

public enum LocationResponse {
    case locationUpdated(CLLocation)
    case locationFailed(Error)
}

public enum GeocodeResponse {
    case success(CLPlacemark)
    case failure(Error)
    case placeNotFound
}

typealias LocationCompletionHandler = (LocationResponse) -> ()
typealias ReverseGeocodeCompletionHandler = (GeocodeResponse) -> ()

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    var locationUpdate: LocationCompletionHandler?
    
    lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.pausesLocationUpdatesAutomatically = true
        manager.headingFilter = kCLHeadingFilterNone
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    var currentLocation: CLLocation?
    var address: String?
    let geoCoder = CLGeocoder()
    
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            break
        }
    }
    
    func reverseGeocodeLocationFrom(_ location: CLLocation, completionHandler : @escaping ReverseGeocodeCompletionHandler) {
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let placemark = placemark, let firstPlacemark = placemark.first {
                completionHandler(.success(firstPlacemark))
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let recent = location.timestamp
        let howRecent = abs(recent.timeIntervalSince1970)
        if howRecent > 15.0 {
            locationUpdate?(.locationUpdated(location))
            currentLocation = location
        }
        
        reverseGeocodeLocationFrom(location) { (response) in
            if case let .success(placemark) = response {
                if let street = placemark.thoroughfare, let ward = placemark.subLocality {
                    self.address = street + "," + ward
                }
            }
        }
    }
}
