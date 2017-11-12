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
    @IBOutlet weak var trackSwitch: UISwitch!
    @IBOutlet weak var switchTitleLabel: UILabel!
    
    override func createViewModel() -> MapViewModel {
        return MapViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthorizationStatus()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        switchTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        switchTitleLabel.textColor = .black
        trackSwitch.isOn = false
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.switchTitle.bind(to: switchTitleLabel.rx.text).addDisposableTo(disposeBag)
        
        trackSwitch.rx.isOn.subscribe(onNext: { [weak self] on in
            guard let `self` = self else { return }
            
            on ? self.viewModel.initJourney() : self.viewModel.sendJourney()
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: - private funcs
    private func updatedUserLocation(with status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways || status == .authorizedWhenInUse)
    }
    
    private func setRegion() {
        let viewRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.location?.coordinate ?? MapViewController.baseCoordinate, MapViewController.baseRegionWidth, MapViewController.baseRegionWidth)
        mapView.setRegion(mapView.regionThatFits(viewRegion), animated: true)
    }
    
    // MARK: - MKMapViewDelegate
    override func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updatedUserLocation(with: status)
        if mapView.showsUserLocation {
            setRegion()
        }
    }

    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setRegion()
        if trackSwitch.isOn {
            viewModel.addCoordinate(locations.map { $0.coordinate } )
        }
    }
}

