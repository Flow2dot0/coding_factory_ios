//
//  MapViewController.swift
//  where
//
//  Created by Lievre Doryan on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    // création du location manager
    let locationManager = CLLocationManager()
    // link avec le MKMapView du main story board
    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // localisationSearchTable
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        // searchBar dans la navbar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        // Customise la searchBar
            //la searchBar disparait quand les resultats sont affichés
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        // fait le liens
       
    }
}


extension MapViewController : CLLocationManagerDelegate {
    // appeler quand le user repond au dialogue
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
     //appeler quand les infos de location arrive
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = locations.first {
        // zoom sur la location de l'utilisateur
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
               let region = MKCoordinateRegion(center: location.coordinate, span: span)
               mapView.setRegion(region, animated: true)
           }
       }
     //affiche l'erreur
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}

        

        
        
        
        
        
      /// other test


//        // positionne la map en fonction des coordonné données.
//        let location = CLLocation(latitude: 48.886433, longitude: 2.287486)
//        // définition du rayon de la region
//        let regionRadius : CLLocationDistance = 1000
//        // centrer la carte par rapport au coordonnées
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//        self.mapView.setRegion(coordinateRegion, animated: true)
//
////        // ajoute un marqeur sur la map
////        let ping = MKPointAnnotation()
////        ping.title = "CodingFactory"
////        ping.coordinate = CLLocationCoordinate2D(latitude: 48.886433, longitude: 2.287486)
////        mapView.addAnnotation(ping)



