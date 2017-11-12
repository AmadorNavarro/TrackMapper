//
//  MapViewController.swift
//  TrackMapper
//
//  Created by BeRepublic on 10/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: BaseViewController<MapViewModel>, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    static let baseCoordinate = CLLocationCoordinate2DMake(41.412504, 2.210131)
    static let baseRegionWidth: CLLocationDistance = 350.0
    static let journeyListPad: CGFloat = 30.0
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var trackSwitch: UISwitch!
    @IBOutlet weak var switchTitleLabel: UILabel!
    
    let journeyListView = JourneysListView(frame: .zero)
    var journeyListShowed = false
    var polygon = MKPolygon()
    
    override func createViewModel() -> MapViewModel {
        return MapViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthorizationStatus()
        setupTableView()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(journeyListView)
        journeyListView.snp.remakeConstraints { [weak self] make in
            guard let `self` = self else { return }
            
            make.leading.equalTo(self.view).inset(MapViewController.journeyListPad)
            make.trailing.equalTo(self.view).inset(MapViewController.journeyListPad)
            make.height.equalTo(UIScreen.main.bounds.height - JourneysListView.headerHeight)
            make.top.equalTo(self.view).inset(UIScreen.main.bounds.height - JourneysListView.headerHeight)
        }
        
        switchTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        switchTitleLabel.textColor = .black
        trackSwitch.isOn = false
    }
    
    override func setupRx() {
        super.setupRx()
        
        journeyListView.viewModel.setup(buttonAction: viewModel.journeysListAction)
        viewModel.switchTitle.bind(to: switchTitleLabel.rx.text).addDisposableTo(disposeBag)
        
        trackSwitch.rx.isOn.subscribe(onNext: { [weak self] on in
            guard let `self` = self else { return }
            
            on ? self.viewModel.initJourney() : self.viewModel.sendJourney()
        }).addDisposableTo(disposeBag)
        
        viewModel.drawPathAction.inputs.subscribe(onNext: { [weak self] locations in
            guard let `self` = self else { return }
            
            self.mapView.remove(self.polygon)
            self.polygon = MKPolygon(coordinates: locations, count: locations.count)
            self.mapView.add(self.polygon)
        }).addDisposableTo(disposeBag)
        
        viewModel.journeysListAction.inputs.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.journeyListShowed = !self.journeyListShowed
            self.journeyListShowed ? self.showJourneysList() : self.hideJourneysList()
        }).addDisposableTo(disposeBag)
        
        viewModel.reloadAction.inputs.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.journeyListView.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
    
    func setupTableView() {
        self.journeyListView.tableView.delegate = self
        self.journeyListView.tableView.dataSource = self
    }
    
    // MARK: - private funcs
    private func updatedUserLocation(with status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways || status == .authorizedWhenInUse)
    }
    
    private func setRegion() {
        let viewRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.location?.coordinate ?? MapViewController.baseCoordinate, MapViewController.baseRegionWidth, MapViewController.baseRegionWidth)
        mapView.setRegion(mapView.regionThatFits(viewRegion), animated: true)
    }
    
    private func showJourneysList() {
        viewModel.updatedJourneysList()
        journeyListView.snp.updateConstraints({ make in
            make.top.equalTo(self.view).inset(JourneysListView.headerHeight * 2)
        })
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideJourneysList() {
        journeyListView.snp.updateConstraints({ make in
            make.top.equalTo(self.view).inset(UIScreen.main.bounds.height - JourneysListView.headerHeight)
        })
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: self.polygon)
        renderer.strokeColor = .red
        renderer.lineWidth = 3.0
        return renderer
    }
    
    // MARK: - CLLocationManagerDelegate
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
    
    // MARK - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JourneyCell", for: indexPath) as? JourneyCell
        cell?.set(viewModel: viewModel.cellViewModelAt(indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath)
    }
}

