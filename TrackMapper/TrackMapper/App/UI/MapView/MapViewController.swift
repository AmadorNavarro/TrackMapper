//
//  MapViewController.swift
//  TrackMapper
//
//  Created by BeRepublic on 10/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController<MapViewModel>, MKMapViewDelegate {

    static let baseCoordinate = CLLocationCoordinate2DMake(41.412504, 2.210131)
    static let baseRegionWidth: CLLocationDistance = 350.0
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func createViewModel() -> MapViewModel {
        return MapViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthorizationStatus()
    }
    
    private func updatedUserLocation(with status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways || status == .authorizedWhenInUse)
    }
    
    // MARK: - MKMapViewDelegate
    override func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updatedUserLocation(with: status)
    }

    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.location?.coordinate ?? MapViewController.baseCoordinate, MapViewController.baseRegionWidth, MapViewController.baseRegionWidth)
        mapView.setRegion(mapView.regionThatFits(viewRegion), animated: true)
    }
}

