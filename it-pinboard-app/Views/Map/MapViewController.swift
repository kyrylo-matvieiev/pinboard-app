//
//  MapViewController.swift
//  it-pinboard-app
//
//  Created by Kyrylo Matvieiev on 7/27/19.
//  Copyright © 2019 Kyrylo Matvieiev. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController  {
    
    private enum Constants {
        static let cameraZoom: Float = 10
        enum Localized {
            static let accessAlertTitle = NSLocalizedString("Need access", comment: "")
            static let accessAlertDescriction = NSLocalizedString("For get current location: you need to get access in settings", comment: "")
            static let accessAlertButton = NSLocalizedString("OK", comment: "")
        }
    }
    
    // MARK: - Properties
    
    private lazy var gMapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.mapType = .normal
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        return mapView
    }()
    
    private var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    private lazy var addPointAlertView: AddPointAlertView? = AddPointAlertView.fromXib()
    private var viewModel: MapViewModelType = MapViewModel()
    private let locationManager = CLLocationManager()
    private var clusterManager: GMUClusterManager!
    
    
    private var coordinateToSave: CLLocationCoordinate2D?
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        checkAuthorization(status: authorizationStatus)
        viewModel.load()
        
        callbacksConfigure()
    }
    
    private func callbacksConfigure() {
        viewModel.pointsListCallback = { [weak self] in
            guard let self = self else { return }
            
            self.gMapView.clear()
            self.clusterManager.clearItems()
            
            for point in self.viewModel.points {
                let coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                let item = POIItem(position: coordinate, name: point.name)
                self.clusterManager.add(item)
            }
            
            self.clusterManager.cluster()
        }
    }

    // MARK: - Configure
    
    private func configureView() {
        parent?.title = MenuItem.map.title
        view = gMapView
        
        configureLocationManager()
        configureClusterManager()
    }
    
    private func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    private func configureClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: gMapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: gMapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    private func checkAuthorization(status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            let accessAlert = UIAlertController(
                title: Constants.Localized.accessAlertTitle,
                message: Constants.Localized.accessAlertDescriction,
                preferredStyle: .alert)
            accessAlert.addAction(UIAlertAction(title: Constants.Localized.accessAlertButton, style: .cancel))
            present(accessAlert, animated: true)
        }
    }
    
    private func replaceViewToPoint(_ point: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition(target: point, zoom: Constants.cameraZoom)
        gMapView.animate(to: camera)
    }
}

// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        addPointAlertView?.delegate = self
        coordinateToSave = coordinate
        view.addSubview(addPointAlertView!)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let mapInfoWindowView = MapInfoWindowView.fromXib()
        mapInfoWindowView?.configure(with: marker.title)
        return mapInfoWindowView
    }
}


// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        replaceViewToPoint(location.coordinate)
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - GMUClusterManagerDelegate

extension MapViewController: GMUClusterManagerDelegate {
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        replaceViewToPoint(cluster.position)
        return true
    }
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        return false
    }
}

// MARK: - GMUClusterRendererDelegate

extension MapViewController: GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, markerFor object: Any) -> GMSMarker? {
        switch object {
        case let clusterItem as POIItem:
            let marker = GMSMarker(position: clusterItem.position)
            marker.title = clusterItem.name
            marker.configureStyle(attach: self.gMapView)
            return marker
        default: return nil
        }
    }
}

// MARK: - AddPointAlertViewDelegate

extension MapViewController: AddPointAlertViewDelegate {
    func saveNewPoint(with name: String) {
        guard let coordinate = coordinateToSave else { return }
        let point = Point(name: name,
                          latitude: coordinate.latitude,
                          longitude: coordinate.longitude)
        
        viewModel.savePoint(point, completion: {
            self.addPointAlertView?.removeFromSuperview()
        })
    }
}

extension GMSMarker {
    func configureStyle(attach toMap: GMSMapView) {
        let image = UIImage(named: "pinMap")?.withRenderingMode(.alwaysTemplate)
        let markerImage = UIImageView(image: image)
        markerImage.tintColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        markerImage.frame.size = CGSize(width: 30, height: 30)
        self.iconView = markerImage
        self.map = toMap
    }
}
