//
//  MapViewController.swift
//  AppWeather
//
//  Created by Can Bas on 11/15/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import MapKit
import UIKit

private enum Constants {
    
}

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    var latitude = 0.0
    var longitude = 0.0
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.delegate = self
        mapView.addAnnotation(annotation)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognizer(press:)))
        longPressRecognizer.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(longPressRecognizer)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: Actions:
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Configure
    
    func annotationAlert(){
        let alert = UIAlertController(title: NSLocalizedString( "add_location", comment: ""), message: nil, preferredStyle: .alert)
        let yesButton = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default) { (_) in
            CoreDataBase.createData(latitude: self.latitude, longitude: self.longitude)
        }
        let noButton = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .destructive) { (_) in
        }
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert,animated: true, completion: nil)
    }
    
    @objc func gestureRecognizer(press: UIGestureRecognizer){
        if press.state == .began {
            let position = press.location(in: mapView)
            let locationCoordinate = mapView.convert(position, toCoordinateFrom: mapView)
            latitude = Double (locationCoordinate.latitude)
            longitude = Double (locationCoordinate.longitude)
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude ,longitude: longitude)
            
            mapView.addAnnotation(annotation)
            annotationAlert()
        }
    }
}

    // MARK: Extensions

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let coordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        mapView.setCenter(coordinate, animated: true)
        mapView.showsUserLocation = true
    }
}
