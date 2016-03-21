//
//  UserDetailViewController.swift
//  babylon
//
//  Created by Julien Klindt on 21.03.16.
//  Copyright © 2016 Julien Klindt. All rights reserved.
//

import UIKit
import MapKit

class UserDetailViewController: BaseViewController, MKMapViewDelegate, UITextViewDelegate {

    var user: NSDictionary?
    
    @IBOutlet var userImage: UIImageView?
    @IBOutlet var userName: UILabel?
    @IBOutlet var mapView: MKMapView?
    @IBOutlet var textView: UITextView?
    
    class func createInstance(router: Router?, networkManager: NetworkManager?, user: NSDictionary?, dataManager: DataManager?) -> UserDetailViewController {
        let moduleStoryboard = UIStoryboard(name: "Posts", bundle: NSBundle(forClass: UserDetailViewController.self))
        let newViewControllerInstance = moduleStoryboard.instantiateViewControllerWithIdentifier("UserDetailViewController") as! UserDetailViewController
        newViewControllerInstance.router = router
        newViewControllerInstance.networkManager = networkManager
        newViewControllerInstance.user = user
        newViewControllerInstance.dataManager = dataManager
        return newViewControllerInstance
    }
    
    override func viewDidLoad() {
        
        if let userEmail = self.user?.valueForKey("email") as? String{
            
            let imageUrl = String(format: Globals.networkManager.apiAvatarUrl, userEmail)
            self.userImage?.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: UIImage(named: "placeholder"))
        }
        
        self.userName?.text = self.user?.valueForKey("username") as? String ?? ""
        
        let coordLatString = self.user?.valueForKey("address")?.valueForKey("geo")?.valueForKey("lat") as? String ?? ""
        let coordLongString = self.user?.valueForKey("address")?.valueForKey("geo")?.valueForKey("lng") as? String ?? ""
        
        let coordLat = Double(coordLatString) ?? 0
        let coordLong = Double(coordLongString) ?? 0
  
        let initialLocation = CLLocationCoordinate2D(latitude: coordLat, longitude: coordLong)
        
        let locationStreet = self.user?.valueForKey("address")?.valueForKey("street") as? String ?? ""
        let locationCity = self.user?.valueForKey("address")?.valueForKey("city") as? String ?? ""
        
        let userLocation = UserAnno(title: self.user?.valueForKey("name") as? String,
            locationName: locationStreet + " " + locationCity,
            coordinate: initialLocation)
        
        self.mapView?.addAnnotation(userLocation)
        
        centerMapOnLocation(initialLocation)
        
        generateInformationText()
    }
    
    func generateInformationText(){
        
        let stringName = self.user?.valueForKey("name") as? String ?? ""
        let stringEmail = self.user?.valueForKey("email") as? String ?? ""
        let stringStreet = self.user?.valueForKey("address")?.valueForKey("street") as? String ?? ""
        let stringSuite = self.user?.valueForKey("address")?.valueForKey("suite") as? String ?? ""
        let stringZipCode = self.user?.valueForKey("address")?.valueForKey("zipcode") as? String ?? ""
        let stringCity = self.user?.valueForKey("address")?.valueForKey("city") as? String ?? ""
        let stringPhone = self.user?.valueForKey("phone") as? String ?? ""
        let stringWebsite = self.user?.valueForKey("website") as? String ?? ""
        let stringCompanyName = self.user?.valueForKey("company")?.valueForKey("name") as? String ?? ""
        let stringCompanyCatch = self.user?.valueForKey("company")?.valueForKey("catchPhrase") as? String ?? ""
        let stringCompanyBs = self.user?.valueForKey("company")?.valueForKey("bs") as? String ?? ""
        
        
        let finalStringFirst = stringName+"\n"+stringEmail+"\n\n"
        let finalStringAddress = stringSuite+"\n"+stringStreet+" "+stringZipCode+"\n"+stringCity+"\n\n"
        let finalStringMore = stringPhone+"\n\n"+stringWebsite+"\n\n"
        let finalStringCompany = stringCompanyName+"\n"+stringCompanyCatch+"\n"+stringCompanyBs

        self.textView?.text = finalStringFirst + finalStringAddress + finalStringMore + finalStringCompany
    }
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        
        
        var span = MKCoordinateSpan()
        span.latitudeDelta = 100.0
        span.longitudeDelta = 100.0
        
        var region = MKCoordinateRegion()
        region.span = span
        region.center = location
        
        self.mapView?.setRegion(region, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnno {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
  
    
}
