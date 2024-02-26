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

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, HamburgerViewControllerDelegate {
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    var session: ARSession!
    var renderer: Renderer!
    @IBOutlet weak var mainBackView: UIView!
    @IBOutlet weak var hamburgerView: UIView!
    @IBOutlet weak var mappingView: UIView!

    @IBOutlet fileprivate weak var leadingConstraintForHamburgerView: NSLayoutConstraint!
    
    @IBOutlet weak var backViewForHamburger: UIView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.backViewForHamburger.isHidden = true
//        self.mainBackView.layer.cornerRadius = 40
        self.mainBackView.layer.cornerRadius = 55
        self.mainBackView.clipsToBounds = true
  }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.mappingView.frame, camera: camera)
        self.mappingView.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        let evMarker = GMSMarker()
        evMarker.position = CLLocationCoordinate2D(latitude: 39.75645, longitude: -105.22592)
        evMarker.title = "ChargePoint Charging Station"
        evMarker.snippet = "EV Charger\n2 Charging Ports\n6.48 kW per charger"
        evMarker.icon = GMSMarker.markerImage(with: .blue)
        evMarker.map = mapView
        
        let evMarker2 = GMSMarker()
        evMarker2.position = CLLocationCoordinate2D(latitude: 39.75695, longitude: -105.22339)
        evMarker2.title = "ChargePoint Charging Station"
        evMarker2.snippet = "EV Charger\n2 Charging Ports\n6.48 kW per charger"
        evMarker2.icon = GMSMarker.markerImage(with: .blue)
        evMarker2.map = mapView

        let evMarker3 = GMSMarker()
        evMarker3.position = CLLocationCoordinate2D(latitude: 39.75599, longitude: -105.22298)
        evMarker3.title = "Tesla Destination Charger"
        evMarker3.snippet = "EV Charger\n2 Charging Ports\n16 kW per charger"
        evMarker3.icon = GMSMarker.markerImage(with: .blue)
        evMarker3.map = mapView

        let evMarker4 = GMSMarker()
        evMarker4.position = CLLocationCoordinate2D(latitude: 39.754679, longitude: -105.221759)
        evMarker4.title = "Golden Stations Astor House"
        evMarker4.snippet = "EV Charger\n2 Charging Ports"
        evMarker4.icon = GMSMarker.markerImage(with: .blue)
        evMarker4.map = mapView

        let evMarker5 = GMSMarker()
        evMarker5.position = CLLocationCoordinate2D(latitude: 39.75633, longitude: -105.22076)
        evMarker5.title = "ChargePoint Charging Station"
        evMarker5.snippet = "EV Charger\n2 Charging Ports\n6.48 kW per charger"
        evMarker5.icon = GMSMarker.markerImage(with: .blue)
        evMarker5.map = mapView

        let evMarker6 = GMSMarker()
        evMarker6.position = CLLocationCoordinate2D(latitude: 39.75521, longitude: -105.22012)
        evMarker6.title = "ChargePoint Charging Station"
        evMarker6.snippet = "EV Charger\n2 Charging Ports\n6.48 kW per charger"
        evMarker6.icon = GMSMarker.markerImage(with: .blue)
        evMarker6.map = mapView

        let evMarker7 = GMSMarker()
        evMarker7.position = CLLocationCoordinate2D(latitude: 39.75134, longitude: -105.22469)
        evMarker7.title = "ChargePoint Charging Station"
        evMarker7.snippet = "EV Charger\n2 Charging Ports\n6.48 kW per charger"
        evMarker7.icon = GMSMarker.markerImage(with: .blue)
        evMarker7.map = mapView

        let evMarker8 = GMSMarker()
        evMarker8.position = CLLocationCoordinate2D(latitude: 39.75071, longitude: -105.21911)
        evMarker8.title = "ChargePoint Charging Station"
        evMarker8.snippet = "EV Charger\n8 Charging Ports\n6.48 kW per charger"
        evMarker8.icon = GMSMarker.markerImage(with: .blue)
        evMarker8.map = mapView

        let evMarker9 = GMSMarker()
        evMarker9.position = CLLocationCoordinate2D(latitude: 39.75167, longitude: -105.21632)
        evMarker9.title = "EV Connect Charging Station"
        evMarker9.snippet = "EV Charger\n6 Charging Ports\n7.2 kW per charger"
        evMarker9.icon = GMSMarker.markerImage(with: .blue)
        evMarker9.map = mapView

        let evMarker10 = GMSMarker()
        evMarker10.position = CLLocationCoordinate2D(latitude: 39.74624, longitude: -105.22113)
        evMarker10.title = "Garage I Lot F"
        evMarker10.snippet = "EV Charger\n2 Charging Ports"
        evMarker10.icon = GMSMarker.markerImage(with: .blue)
        evMarker10.map = mapView

        let coorsMarker = GMSMarker()
        coorsMarker.position = CLLocationCoordinate2D(latitude: 39.75825, longitude: -105.21668)
        coorsMarker.title = "Coors Brewery Overhaul"
        coorsMarker.snippet = "Carbon Offset Projects\nWhen completed, Molson Coors brewery will be one of the worlds most efficient breweries\nThe overhaul will reduce waste by 35%, capture 30% more carbon dioxide and reduce energy usage by 30%"
        // coorsMarker.userData = "https://www.molsoncoorsblog.com/golden-brewery-g150-sustainablility"
        coorsMarker.icon = GMSMarker.markerImage(with: .systemTeal)
        coorsMarker.map = mapView

        let solarMarker = GMSMarker()
        solarMarker.position = CLLocationCoordinate2D(latitude: 39.75159, longitude: -105.22046)
        solarMarker.title = "Green Center"
        solarMarker.snippet = "Solar Panels\nSystem Capacity: 372 kW\nPower Produced in Year 1: 507,122 kWh"
        solarMarker.icon = GMSMarker.markerImage(with: .green)
        solarMarker.map = mapView

        let solarMarker2 = GMSMarker()
        solarMarker2.position = CLLocationCoordinate2D(latitude: 39.75262, longitude: -105.22372)
        solarMarker2.title = "Steinhauer Fieldhouse"
        solarMarker2.snippet = "Solar Panels\nSystem Capacity: 241 kW\nPower Produced in Year 1: 328,208 kWh"
        solarMarker2.icon = GMSMarker.markerImage(with: .green)
        solarMarker2.map = mapView
        
        let solarMarker3 = GMSMarker()
        solarMarker3.position = CLLocationCoordinate2D(latitude: 39.75254, longitude: -105.22727)
        solarMarker3.title = "Korell Athletics Center"
        solarMarker3.snippet = "Solar Panels\nSystem Capacity: 83 kW\nPower Produced in Year 1: 110,298 kWh"
        solarMarker3.icon = GMSMarker.markerImage(with: .green)
        solarMarker3.map = mapView
        
        let solarMarker4 = GMSMarker()
        solarMarker4.position = CLLocationCoordinate2D(latitude: 39.74954, longitude: -105.22260)
        solarMarker4.title = "Mines Student Rec Center"
        solarMarker4.snippet = "Solar Panels\nSystem Capacity: 186 kW\nPower Produced in Year 1: 251,144 kWh"
        solarMarker4.icon = GMSMarker.markerImage(with: .green)
        solarMarker4.map = mapView
        
        let solarMarker5 = GMSMarker()
        solarMarker5.position = CLLocationCoordinate2D(latitude: 39.75132, longitude: -105.22624)
        solarMarker5.title = "General Research Lab Annex"
        solarMarker5.snippet = "Solar Panels\nSystem Capacity: 83 kW\nPower Produced in Year 1: 106,415 kWh"
        solarMarker5.icon = GMSMarker.markerImage(with: .green)
        solarMarker5.map = mapView
        
        let solarMarker6 = GMSMarker()
        solarMarker6.position = CLLocationCoordinate2D(latitude: 39.75333, longitude: -105.22923)
        solarMarker6.title = "K Lot Solar Canopy"
        solarMarker6.snippet = "Solar Panels\nSystem Capacity: 495 kW\nPower Produced in Year 1: 670,011 kWh"
        solarMarker6.icon = GMSMarker.markerImage(with: .green)
        solarMarker6.map = mapView
        
        let solarMarker7 = GMSMarker()
        solarMarker7.position = CLLocationCoordinate2D(latitude: 39.75130, longitude: -105.21648)
        solarMarker7.title = "1750 Jackson St"
        solarMarker7.snippet = "Solar Panels\nSystem Capacity: 56 kW\n"
        solarMarker7.icon = GMSMarker.markerImage(with: .green)
        solarMarker7.map = mapView
        
        let solarMarker8 = GMSMarker()
        solarMarker8.position = CLLocationCoordinate2D(latitude: 39.75148, longitude: -105.22437)
        solarMarker8.title = "McNeil Hall Parking Garage"
        solarMarker8.snippet = "Solar Panels\nSystem Capacity: 74 kW\n"
        solarMarker8.icon = GMSMarker.markerImage(with: .green)
        solarMarker8.map = mapView
        
        let gardenMarker = GMSMarker()
        gardenMarker.position = CLLocationCoordinate2D(latitude: 39.75421, longitude: -105.23333)
        gardenMarker.title = "Golden Community Garden"
        gardenMarker.snippet = "Photosynthesizer\n"
        gardenMarker.icon = GMSMarker.markerImage(with: .systemPink)
        gardenMarker.map = mapView
        
        let gardenMarker2 = GMSMarker()
        gardenMarker2.position = CLLocationCoordinate2D(latitude: 39.76165, longitude: -105.23194)
        gardenMarker2.title = "Mitchell Elementary School Garden"
        gardenMarker2.snippet = "Photosynthesizer\nPlants are responsible for absorbing between a quarter to a third of all\nhuman-caused carbon emissions per year."
        gardenMarker2.icon = GMSMarker.markerImage(with: .systemPink)
        gardenMarker2.map = mapView
        
        let orecartMarker = GMSMarker()
        orecartMarker.position = CLLocationCoordinate2D(latitude: 39.75018, longitude: -105.21937)
        orecartMarker.title = "Orecart Tungsten Route"
        // (350g of CO2 per mile driven in a car on average) * (~4 miles roundtrip on a drive to campus for a student within Orecart range) * (5 days per week) * (32 weeks of school per year) = ~224000 grams of carbon offset taking the Orecart
        orecartMarker.snippet = "Transportation\nOn average, a student will reduce their carbon emissions by 224,000g per year\nby riding the Orecart to campus during the school year."
        orecartMarker.map = mapView
        
        let orecartMarker2 = GMSMarker()
        orecartMarker2.position = CLLocationCoordinate2D(latitude: 39.75092, longitude: -105.22318)
        orecartMarker2.title = "Orecart Silver Route"
        orecartMarker2.snippet = "Transportation\nOn average, a student will reduce their carbon emissions by 224,000g per year\nby riding the Orecart to campus during the school year."
        orecartMarker2.map = mapView
        
        let orecartMarker3 = GMSMarker()
        orecartMarker3.position = CLLocationCoordinate2D(latitude: 39.75228, longitude: -105.22478)
        orecartMarker3.title = "Orecart Gold Route"
        orecartMarker3.snippet = "Transportation\nOn average, a student will reduce their carbon emissions by 224,000g per year\nby riding the Orecart to campus during the school year."
        orecartMarker3.map = mapView
        
        let orecartMarker0 = GMSMarker()
        orecartMarker0.position = CLLocationCoordinate2D(latitude: 39.75786, longitude: -105.22266)
        orecartMarker0.title = "RTD Bus Station"
        orecartMarker0.snippet = "Transportation\nUsing public transit creates 84% less carbon emissions than driving a car"
        orecartMarker0.map = mapView
    }
    
    // BELOW IS NOT MY CODE:
    @IBAction func tappedOnHamburgerbackView(_ sender: Any) {
           self.hideHamburgerView()
       }
       
       func hideHamburgerMenu() {
           self.hideHamburgerView()
       }
       
       private func hideHamburgerView()
       {
           UIView.animate(withDuration: 0.1) {
               self.leadingConstraintForHamburgerView.constant = 10
               self.view.layoutIfNeeded()
           } completion: { (status) in
               self.backViewForHamburger.alpha = 0.0
               UIView.animate(withDuration: 0.1) {
                   self.leadingConstraintForHamburgerView.constant = -280
                   self.view.layoutIfNeeded()
               } completion: { (status) in
                   self.backViewForHamburger.isHidden = true
                   self.isHamburgerMenuShown = false
               }
           }
       }
    @IBAction func showHamburgerMenu(_ sender: Any) {
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = 10
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.backViewForHamburger.alpha = 0.75
                self.backViewForHamburger.isHidden = false
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstraintForHamburgerView.constant = 0
                    self.view.layoutIfNeeded()
                } completion: { (status) in
                    self.isHamburgerMenuShown = true
                }

            }

            self.backViewForHamburger.isHidden = false
            
        }
        
        var hamburgerViewController : HamburgerViewController?
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "hamburgerSegue")
            {
                if let controller = segue.destination as? HamburgerViewController
                {
                    self.hamburgerViewController = controller
                    self.hamburgerViewController?.delegate = self
                }
            }
        }
        
        private var isHamburgerMenuShown:Bool = false
        private var beginPoint:CGFloat = 0.0
        private var difference:CGFloat = 0.0
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (isHamburgerMenuShown)
            {
                 if let touch = touches.first
                {
                    let location = touch.location(in: backViewForHamburger)
                    beginPoint = location.x
                }
            }
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (isHamburgerMenuShown)
            {
                if let touch = touches.first
                {
                    let location = touch.location(in: backViewForHamburger)
                    
                    let differenceFromBeginPoint = beginPoint - location.x
                    
                    if (differenceFromBeginPoint>0 || differenceFromBeginPoint<280)
                    {
                        difference = differenceFromBeginPoint
                        self.leadingConstraintForHamburgerView.constant = -differenceFromBeginPoint
                        self.backViewForHamburger.alpha = 0.75-(0.75*differenceFromBeginPoint/280)
                    }
                }
            }
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (isHamburgerMenuShown)
            {
                if (difference>140)
                {
                    UIView.animate(withDuration: 0.1) {
                        self.leadingConstraintForHamburgerView.constant = -290
                    } completion: { (status) in
                        self.backViewForHamburger.alpha = 0.0
                        self.isHamburgerMenuShown = false
                        self.backViewForHamburger.isHidden = true
                    }
                }
                else{
                    UIView.animate(withDuration: 0.1) {
                        self.leadingConstraintForHamburgerView.constant = -10
                    } completion: { (status) in
                        self.backViewForHamburger.alpha = 0.75
                        self.isHamburgerMenuShown = true
                        self.backViewForHamburger.isHidden = false
                    }
                }
            }
        }
}
