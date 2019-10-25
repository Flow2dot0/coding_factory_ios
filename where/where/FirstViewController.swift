//
//  FirstViewController.swift
//  where
//
//  Created by Leprohon cedric on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {
    // les link avec lke storyboard
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var libTitle: UILabel!
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    var longitude : String = "";
    var latitude : String = "";
    var address : String = "";
    
    
    var travelTimeDuration: Any = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        // Do any additional setup after loading the view.
        //lblTitle.text = NSLocalizedString("title_text", comment: "")
        
        if(SettingsController.isDarkModeEnabled())
        {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .dark
            }
        }else {
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            }
        }
    }
    

    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func centerViewOnUserLocation() {
           if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(location, regionInMeters, regionInMeters)
               mapView.setRegion(region, animated: true)
           }
       }
    // création du location manager
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // indiquer à l'utilisateur comment changer ses paramètre de localisation

        }
    }
     // vérifie " l'état" du service de localisation
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // indiquer à l'utilisateur comment changer ses paramètre de localisation au moyen d'une alerte
            break
        case .notDetermined:
             // Demande de permission
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // domage on y peut rien :/
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }


        func getCenterLocation(for mapView: MKMapView) -> CLLocation {
            
            self.latitude = String(format : "%f", mapView.centerCoordinate.latitude)
            self.longitude = String(format : "%f", mapView.centerCoordinate.longitude)
            
            print (self.latitude, self.longitude)
            print(self.address)
            
            return CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        }
    
 

    @IBAction func sendData(_ sender: Any) {
        
        let result = ResultViewController()
        let tmpFormat = self.latitude+"%2C"+self.longitude
        result.coordEnd = tmpFormat
        print("j'envoie")
    }
//    func SendData(sender :UIButton) -> String {
//        let result = ResultViewController()
//        let tmpFormat = self.latitude+"%2C"+self.longitude
//        result.coordEnd = tmpFormat
//        print("j'envoie")
//
//        return tmpFormat
//    }
}







// Extension pour tous les delegate
extension FirstViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension FirstViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        // gestion des erreur à faire
            // envoyer une données de location spécifique de manière async
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                
                return
            }
            
            guard let placemark = placemarks?.first else {
                
                return
            }
            
            // récupérer les numéros et nom des rues
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            self.address = streetNumber + streetName
                print(streetName)
                
            
            DispatchQueue.main.async {
                self.libTitle.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}




