//
//  AppPinController.swift
//  locationTest2
//
//  Created by Arjun TP on 2021-09-30.
//


import UIKit
import CoreData

class AppPinController: UIViewController {
    
    var callerCallback:(()->())?
    var selectedLocation:Locations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        if let location = selectedLocation{
            titleText.text = location.title
            subTitleText.text = location.subtitle
            lattitudeText.text = String(location.lattitude)
            longitudeText.text = String(location.longitude)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if let location = selectedLocation {
            do{
                print("Delete successful \(String(describing: location.title))")
                context.delete(location)
                try context.save()
                if let callback = callerCallback {
                    callback()
                }
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                
            }catch {
                print("Error deleting location pin")
            }
        }
    }
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var subTitleText: UITextField!
    
    @IBOutlet weak var lattitudeText: UITextField!
    
    @IBOutlet weak var longitudeText: UITextField!
    
    @IBAction func saveData(_ sender: Any) {
        
        if((titleText.text?.isEmpty) == nil) {
            print("title is empty")
        }
        else if((subTitleText.text?.isEmpty) == nil) {
            print("subTitle is empty")
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let locationEntity = NSEntityDescription.insertNewObject(forEntityName: "Locations", into: context) as! Locations
            
            locationEntity.title = titleText.text
            locationEntity.subtitle = subTitleText.text
            locationEntity.lattitude = Double(lattitudeText.text!) ?? 0
            locationEntity.longitude = Double(longitudeText.text!) ?? 0
            do{
                try context.save()
                print ("Saved data \(String(describing: locationEntity.title)) \(String(describing: locationEntity.subtitle)) \(locationEntity.longitude) \(locationEntity.lattitude) ")
                
                if let callback = callerCallback {
                    callback()
                }
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                
            }catch{
                print ("error saving location")
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
