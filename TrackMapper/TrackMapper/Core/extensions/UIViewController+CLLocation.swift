//
//  UIViewController+CLLocation.swift
//  Droppit
//
//  Created by Amador Navarro on 18/10/2017.
//  Copyright © 2017 Amador Navarro. All rights reserved.
//

import UIKit
import CoreLocation

protocol SeatLocationDelegate {
    func updatedLocation(locations: [CLLocation])
}

extension UIViewController: CLLocationManagerDelegate {
    
    private struct LocationKeys {
        static var locationName = "cll_locationmanager"
        static var locationDelegate = "cll_delegate"
    }
    
    var delegateLocation: SeatLocationDelegate? {
        get {
            return objc_getAssociatedObject(self, &LocationKeys.locationDelegate) as? SeatLocationDelegate
        }
        set {
            objc_setAssociatedObject(self, &LocationKeys.locationDelegate, newValue ?? nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var locationManager: CLLocationManager? {
        get {
            return objc_getAssociatedObject(self, &LocationKeys.locationName) as? CLLocationManager
        }
        set {
            objc_setAssociatedObject(self, &LocationKeys.locationName, newValue ?? nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func checkAuthorizationStatus() {
        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
        }
        
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    locationManager.startUpdatingLocation()
                default:
                    requiredAccessToGeoloation()
                }
            } else {
                requiredAccessToGeoloation()
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.first != nil) {
            self.delegateLocation?.updatedLocation(locations: locations)
            self.locationManager?.stopUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO: Control when autorized first time // reload
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func requiredAccessToGeoloation() {
        let alertController = UIAlertController(title: "permission_location_title" , message: "permission_location_description", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .default) { action in
            self.dismiss(animated: true)
        }
        let OKAction = UIAlertAction(title: "settings", style: .cancel) { action in
            if let settings = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(settings, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
