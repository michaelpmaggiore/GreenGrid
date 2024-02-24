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
