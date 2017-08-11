//
//  ViewController.swift
//  MapView
//
//  Created by jaeseong on 2017. 8. 4..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var locationLabel1:UILabel!
    @IBOutlet var locationLabel2:UILabel!
    
    @IBAction func segmentChangeLocation(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            self.locationLabel1.text = ""
            self.locationLabel2.text = ""
            locationManager.startUpdatingLocation()
            
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitude: 36.505456, longitude: 126.621647, delta: 0.01, title: "우리집", subtitle: "광천아파트")
            self.locationLabel1.text = "보고있는위치"
            self.locationLabel2.text = "우리집"
            
        }else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitude: 35.941148, longitude: 127.106163, delta: 0.1, title: "혜진이네집", subtitle: "구암리이장댁")
            self.locationLabel1.text = "보고있는위치"
            self.locationLabel2.text = "구암리이장댁"

        }
    }

    let locationManager = CLLocationManager()
    
}


extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel1.text = ""
        locationLabel2.text = ""
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        
    }
}

extension ViewController {
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpanMake(span, span)
        
        let pRegion = MKCoordinateRegionMake(pLocation, spanValue)
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span : Double, title strTitle:String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!) { (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            if pm!.locality != nil {
                address += ""
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += ""
                address += pm!.thoroughfare!
            }
            
            self.locationLabel1.text = "현재위치"
            self.locationLabel2.text = address
        }
        locationManager.stopUpdatingLocation()
        
    }
}
