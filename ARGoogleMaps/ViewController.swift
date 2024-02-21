//
//  ViewController.swift
//  ARGoogleMaps
//
//  Created by Michael Maggiore on 2/21/24.
//

import UIKit
import Metal
import MetalKit
import ARKit
import GoogleMaps
import GooglePlaces
import CoreLocation

extension MTKView : RenderDestinationProvider {
}

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    var session: ARSession!
    var renderer: Renderer!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
  }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}
