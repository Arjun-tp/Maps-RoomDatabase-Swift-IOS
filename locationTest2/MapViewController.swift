//
//  MapViewController.swift
//  locationTest2
//
//  Created by Arjun TP on 2021-09-30.
//
import UIKit
import CoreData
import MapKit

class MapViewController: UIViewController {

    var context:NSManagedObjectContext!
    var locations:[Locations]!
    var selectedLocation:Locations?
    
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        updatePins()
    }

    func updatePins(){
        selectedLocation = nil
        locations = fetchPins()
        mapview.removeAnnotations(mapview.annotations)
        mapview.showAnnotations(locations, animated: true)
    }

    func fetchPins() -> [Locations]?{
                    
        let request = Locations.fetchRequest() as NSFetchRequest<Locations>
        do{
            let locations = try context.fetch(request)
            print("fetch location success got \(locations.count) items")
            return locations
        } catch {
            print ("Error while fetching location")
        }
        return nil
    }
    
    @objc func editLocationDetails(_ sender: UIButton){
        selectedLocation = locations[sender.tag]
        performSegue(withIdentifier: "ToEditSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToEditSegue"){
            let dest = segue.destination as! AppPinController
            dest.callerCallback = updatePins
            dest.selectedLocation = selectedLocation
        }
    }
}


extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Locations else {
            print("return nil in mapview viewFor method")
            return nil
        }
        
        let identifier = "location"
        var annotationView = mapview.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.isEnabled = true
            pinView.canShowCallout = true
            pinView.animatesDrop = false
        //    pinView.pinTintColor = UIColor(red: 0.32, green: 0.82, blue: 0.4, alpha: 1)
            
            let righButton = UIButton(type: .detailDisclosure)
            righButton.addTarget(self, action: #selector(editLocationDetails), for: .touchUpInside)
            pinView.rightCalloutAccessoryView = righButton
            annotationView = pinView
        }
        
        if let annotationView = annotationView{
            annotationView.annotation = annotation
            let button = annotationView.rightCalloutAccessoryView as! UIButton
            
            if let index = locations.firstIndex(of: annotation as! Locations){
                button.tag = index
            }
        }
        return annotationView
    }
    
    
}
